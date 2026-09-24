@m01
Feature: primer saludo personalizado

  Scenario: un saludo simple con validación de tipo
    * def mensaje = 'hola'
    * match mensaje == '#string'
    * match mensaje == 'hola'
