@m02
Feature: DSL, variables y match

  Background:
    * def iva = 0.21
    * def conIva = function(precio) { return precio * (1 + iva) }

  Scenario: variables, tipos y comparaciones
    * def nombre = 'Teclado'
    * def precio = 25
    * def etiquetas = ['gaming', 'teclado']
    * def producto = { nombre: nombre, precio: precio, stock: 12 }

    * match nombre == 'Teclado'
    * match precio == 25
    * match etiquetas == '#array'
    * match etiquetas == '#[2]'
    * match producto == '#object'
    * match producto.stock == '#number'
    * match producto.nombre == '#string'
    * match etiquetas[0] == '#string'

  Scenario: IVA de un teclado
    * def resultado = conIva(25)
    * match resultado == 30.25
