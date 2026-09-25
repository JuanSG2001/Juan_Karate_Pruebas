Feature: Mock de pedidos para el ejercicio ampliado M08

  Background:
    * configure cors = true

  Scenario: pathMatches('/usuarios/{id}') && methodIs('get')
    * def clientId = parseInt(pathParams.id)
    * def vip = clientId == 1
    * def nombre = 'Cliente-' + clientId
    * def response =
      """
      {
        id: '#(clientId)',
        nombre: '#(nombre)',
        vip: '#(vip)'
      }
      """

  Scenario: pathMatches('/pedidos') && methodIs('post')
    * def total = (request.productos[0].precio * request.productos[0].cantidad) + (request.productos[1].precio * request.productos[1].cantidad)
    * def orderId = 'PED-' + request.clienteId + '-' + java.lang.System.currentTimeMillis()
    * def responseStatus = 201
    * def response =
      """
      {
        id: '#(orderId)',
        clienteId: '#(request.clienteId)',
        cupon: '#(request.cupon)',
        estado: 'creado',
        total: '#(total)',
        productos: '#(request.productos)'
      }
      """

  Scenario: pathMatches('/pedidos/{id}/cancelar') && methodIs('post')
    * def response =
      """
      {
        id: '#(pathParams.id)',
        estado: 'cancelado'
      }
      """
