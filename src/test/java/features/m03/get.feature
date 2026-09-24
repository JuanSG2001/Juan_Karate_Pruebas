@m03
@http-get
Feature: GET de productos y usuarios

  Background:
    * url baseUrl

  Scenario: listar productos
    Given path 'productos'
    When method get
    Then status 200
    And match response == '#[3]'
    And match response[0].id == 1

  Scenario: obtener un producto por id
    Given path 'productos', 2
    When method get
    Then status 200
    And match response.nombre == 'Monitor'
    And match response.categoria == 'pantalla'

  Scenario: filtrar productos por categoria
    Given path 'productos'
    And param categoria = 'periferico'
    When method get
    Then status 200
    And match response == '#[2]'
    And match each response contains { categoria: 'periferico' }

  Scenario: producto no encontrado
    Given path 'productos', 999
    When method get
    Then status 404
    And match response.mensaje == 'Producto no encontrado'

  Scenario: obtener usuario por id
    Given path 'usuarios', 1
    When method get
    Then status 200
    And match response.nombre == 'Ana'
