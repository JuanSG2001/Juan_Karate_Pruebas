package runners;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class KarateSummaryGenerator {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    public static void main(String[] args) throws IOException {
        Path reportsDir = Paths.get("target", "karate-reports");
        if (Files.notExists(reportsDir)) {
            return;
        }

        List<Path> jsonFiles = Files.list(reportsDir)
                .filter(path -> path.getFileName().toString().endsWith(".karate-json.txt"))
                .sorted()
                .collect(Collectors.toList());

        List<String> rows = new ArrayList<>();
        int totalScenarios = 0;
        int totalPassed = 0;
        int totalFailed = 0;

        for (Path jsonFile : jsonFiles) {
            Map<String, Object> report = MAPPER.readValue(jsonFile.toFile(), Map.class);

            Object rawName = report.get("relativePath");
            String featureName = rawName == null ? jsonFile.getFileName().toString() : rawName.toString();
            Object rawScenarioResults = report.get("scenarioResults");
            List<?> scenarioResults = rawScenarioResults == null ? Collections.emptyList() : (List<?>) rawScenarioResults;
            int scenarioCount = scenarioResults.size();
            int failedCount = asInt(report.get("failedCount"));
            int passedCount = scenarioCount - failedCount;

            totalScenarios += scenarioCount;
            totalPassed += passedCount;
            totalFailed += failedCount;

            rows.add("<tr><td>" + escapeHtml(featureName) + "</td><td>" + scenarioCount + "</td><td>" + passedCount + "</td><td>" + failedCount + "</td></tr>");
        }

        StringBuilder html = new StringBuilder();
        html.append("<!doctype html>\n")
                .append("<html lang='es'>\n")
                .append("<head>\n")
                .append("  <meta charset='UTF-8'>\n")
                .append("  <title>Karate summary</title>\n")
                .append("  <style>\n")
                .append("    body { font-family: Arial, sans-serif; margin: 24px; background: #f6f8fa; color: #1f2937; }\n")
                .append("    h1 { margin-bottom: 16px; }\n")
                .append("    .summary { display: flex; gap: 16px; margin-bottom: 20px; }\n")
                .append("    .card { background: white; border: 1px solid #dbe3ec; border-radius: 8px; padding: 12px 20px; }\n")
                .append("    table { width: 100%; border-collapse: collapse; background: white; border: 1px solid #dbe3ec; }\n")
                .append("    th, td { border-bottom: 1px solid #e5e7eb; padding: 10px 12px; text-align: left; }\n")
                .append("    th { background: #eef2ff; }\n")
                .append("    .ok { color: #166534; }\n")
                .append("    .fail { color: #b91c1c; }\n")
                .append("  </style>\n")
                .append("</head>\n")
                .append("<body>\n")
                .append("  <h1>Resumen de pruebas Karate</h1>\n")
                .append("  <div class='summary'>\n")
                .append("    <div class='card'><strong>Escenarios:</strong> ").append(totalScenarios).append("</div>\n")
                .append("    <div class='card'><strong>OK:</strong> <span class='ok'>").append(totalPassed).append("</span></div>\n")
                .append("    <div class='card'><strong>Fallidos:</strong> <span class='fail'>").append(totalFailed).append("</span></div>\n")
                .append("  </div>\n")
                .append("  <table>\n")
                .append("    <thead>\n")
                .append("      <tr>\n")
                .append("        <th>Feature</th>\n")
                .append("        <th>Escenarios</th>\n")
                .append("        <th>OK</th>\n")
                .append("        <th>Fallidos</th>\n")
                .append("      </tr>\n")
                .append("    </thead>\n")
                .append("    <tbody>\n")
                .append(String.join("\n", rows))
                .append("\n    </tbody>\n")
                .append("  </table>\n")
                .append("</body>\n")
                .append("</html>\n");

        Files.writeString(reportsDir.resolve("karate-summary.html"), html.toString());
    }

    private static int asInt(Object value) {
        if (value == null) {
            return 0;
        }
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        return Integer.parseInt(String.valueOf(value));
    }

    private static String escapeHtml(String value) {
        return value.replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }
}
