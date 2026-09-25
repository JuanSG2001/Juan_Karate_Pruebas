@m08 @extendido
Feature: ejercicio ampliado con mock, helper, DDT y validaciones

  Background:
    * def mock = karate.start('classpath:mock/gestion-pedidos.feature')
    * url 'http://localhost:' + mock.port

  Scenario Outline: flujo de compra con validaciones y reutilizacion de cliente
    * def baseUrl = 'http://localhost:' + mock.port
    * def cliente = call read('classpath:features/helpers/cliente.feature') { id: <clienteId> }
    * match cliente.response.id == <clienteId>
    * match cliente.response.vip == <vip>

    * def payload =
      """
      {
        clienteId: <clienteId>,
        cupon: "<cupon>",
        productos: [
          { id: 1, cantidad: <cantidad1>, precio: <precio1> },
          { id: 2, cantidad: <cantidad2>, precio: <precio2> }
        ]
      }
      """

    * path 'pedidos'
    * request payload
    * method post
    * status 201
    * match response.id == '#regex PED-[0-9]+-[0-9]+'
    * match response.clienteId == <clienteId>
    * match response.estado == 'creado'
    * match response.total == <totalEsperado>
    * match response.cupon == '<cupon>'
    * match response.productos == '#array'
    * match each response.productos == { id: '#number', cantidad: '#number', precio: '#number' }

    * def pedidoId = response.id
    * path 'pedidos', pedidoId, 'cancelar'
    * method post
    * status 200
    * match response.id == pedidoId
    * match response.estado == 'cancelado'

    Examples:
      | clienteId | vip   | cupon    | cantidad1 | precio1 | cantidad2 | precio2 | totalEsperado |
      | 1         | true  | VIP      | 2         | 25      | 1         | 35      | 85            |
      | 2         | false | SIN-CUP  | 1         | 40      | 3         | 15      | 85            |
