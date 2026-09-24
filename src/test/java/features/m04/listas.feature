@m04
@listas
Feature: listas y JSONPath

  Background:
    * url baseUrl
    * def productos = call read('classpath:features/m03/get.feature@ignore')

  Scenario: validar tamaño y primer elemento del array
    Given path 'productos'
    When method get
    Then status 200
    And match response == '#[3]'
    And match response[0].nombre == 'Teclado'

  Scenario: validar esquema de cada elemento con match each
    Given path 'productos'
    When method get
    Then status 200
    And match each response ==
      """
      {
        id: '#number',
        nombre: '#string',
        precio: '#number',
        categoria: '#string',
        stock: '#number'
      }
      """

  Scenario: JSONPath con ids y categorias
    Given path 'productos'
    When method get
    Then status 200
    And match response[*].id contains 2
    And match response[*].categoria contains 'pantalla'
    And match response[*].nombre contains 'Webcam'
