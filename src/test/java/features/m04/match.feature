@m04
@validaciones
Feature: validaciones con match y esquema

  Background:
    * url baseUrl

  Scenario: validar un producto concreto con igualdad y tipo
    Given path 'productos', 1
    When method get
    Then status 200
    And match response.nombre == 'Teclado'
    And match response.precio == 25
    And match response.id == '#number'

  Scenario: contains sobre un objeto
    Given path 'productos', 1
    When method get
    Then status 200
    And match response contains { id: 1, categoria: 'periferico' }

  Scenario: esquema completo del producto
    Given path 'productos', 1
    When method get
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        nombre: '#string',
        precio: '#number',
        categoria: '#string',
        stock: '#number'
      }
      """

  Scenario: esquema de usuaria
    Given path 'usuarios', 1
    When method get
    Then status 200
    And match response ==
      """
      {
        id: '#number',
        nombre: '#string',
        rol: '#string',
        activo: '#boolean'
      }
      """
