@m06 @ddt-tabla
Feature: DDT con tabla embebida

  Scenario Outline: obtener producto por id desde ejemplos inline
    * url baseUrl
    * path 'productos', <id>
    * method get
    * status 200
    * match response.id == <id>
    * match response.nombre == '<nombre>'
    * match response.categoria == '<categoria>'

    Examples:
      | id | nombre  | categoria   |
      | 1  | Teclado | periferico  |
      | 2  | Monitor | pantalla    |
      | 3  | Webcam  | periferico  |
