@m06 @ddt-ficheros
Feature: DDT con CSV y JSON

  Scenario Outline: leer productos desde CSV y comprobar precio
    * url baseUrl
    * path 'productos', <id>
    * method get
    * status 200
    * match response.id == <id>
    * match response.precio == <precio>

    Examples:
      | read('productos.csv') |

  Scenario Outline: leer casos desde JSON y comprobar nombre
    * url baseUrl
    * path 'productos', <id>
    * method get
    * status 200
    * match response.id == <id>
    * match response.nombre == '<nombre>'

    Examples:
      | read('casos.json') |
