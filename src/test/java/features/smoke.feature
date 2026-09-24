@smoke
Feature: smoke test del mock de la tienda

  Background:
    * url baseUrl

  Scenario: GET a productos devuelve la lista inicial
    Given path 'productos'
    When method get
    Then status 200
    And match response[0].nombre == 'Teclado'
    And match response[1].nombre == 'Monitor'
    And match response[2].nombre == 'Webcam'
