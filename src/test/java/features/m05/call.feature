@m05
Feature: reutilizacion con call y config

  Scenario: obtener producto 2
    * def respuestaProducto2 = call read('classpath:features/helpers/get-producto.feature') { id: 2 }
    * match respuestaProducto2.response.nombre == 'Monitor'

  Scenario: obtener producto 1
    * def respuestaProducto1 = call read('classpath:features/helpers/get-producto.feature') { id: 1 }
    * match respuestaProducto1.response.nombre == 'Teclado'

  Scenario: obtener usuario 1
    * def respuestaUsuario1 = call read('classpath:features/helpers/get-usuario.feature') { id: 1 }
    * match respuestaUsuario1.response.nombre == 'Ana'
