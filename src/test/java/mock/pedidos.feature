Feature: Mock de pedidos para el laboratorio M07

  Background:
    * configure cors = true

  Scenario: pathMatches('/pedidos/{id}') && methodIs('get')
    * def response =
      """
      {
        id: '#(pathParams.id)',
        estado: 'enviado',
        items: 2
      }
      """

  Scenario: pathMatches('/pedidos') && methodIs('post')
    * def responseStatus = 201
    * def response =
      """
      {
        id: '88',
        estado: 'creado'
      }
      """

  Scenario:
    * def responseStatus = 404
    * def response = { mensaje: 'Pedido no mockeado' }
