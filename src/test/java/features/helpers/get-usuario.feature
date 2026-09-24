@ignore
Feature: helper para obtener un usuario por id

  Scenario:
    * url baseUrl
    * path 'usuarios', id
    * method get
    * status 200
