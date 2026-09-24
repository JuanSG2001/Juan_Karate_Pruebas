@m03
@http-write
Feature: POST, PUT, PATCH y DELETE de productos

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'

  Scenario: crear un producto con POST
    Given path 'productos'
    And request { nombre: 'Dock USB', precio: 60, categoria: 'periferico', stock: 5 }
    When method post
    Then status 201
    And match response.id == 99
    And match response.nombre == 'Dock USB'
    And match response.precio == 60

  Scenario: actualizar un producto con PUT
    Given path 'productos', 1
    And request { nombre: 'Teclado mecánico', precio: 90, categoria: 'periferico', stock: 3 }
    When method put
    Then status 200
    And match response.id == 1
    And match response.nombre == 'Teclado mecánico'
    And match response.precio == 90

  Scenario: actualizar stock con PATCH
    Given path 'productos', 3
    And request { stock: 1 }
    When method patch
    Then status 200
    And match response.id == 3
    And match response.stock == 1

  Scenario: borrar un producto con DELETE
    Given path 'productos', 2
    When method delete
    Then status 204

  Scenario: el catálogo sigue sin persistir cambios
    Given path 'productos'
    When method get
    Then status 200
    And match response == '#[3]'
    And match response[0].nombre == 'Teclado'
