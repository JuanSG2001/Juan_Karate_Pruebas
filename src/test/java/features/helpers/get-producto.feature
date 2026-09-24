@ignore
Feature: helper para obtener un producto por id

  Scenario:
    * url baseUrl
    * path 'productos', id
    * method get
    * status 200
