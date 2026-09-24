function fn() {
  var env = karate.env || 'dev';
  var mock = karate.callSingle('classpath:mock/start.js');

  return {
    env: env,
    baseUrl: 'http://localhost:' + mock.port
  };
}
