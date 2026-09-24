@m07
Feature: mock de pedidos arrancado con karate.start

  Background:
    * def mock = karate.start('classpath:mock/pedidos.feature')
    * url 'http://localhost:' + mock.port

  Scenario: consultar pedido 77
    * path 'pedidos', 77
    * method get
    * status 200
    * match response.id == '77'
    * match response.estado == 'enviado'
    * match response.items == 2

  Scenario: crear pedido
    * path 'pedidos'
    * request { cliente: 'Ana', items: 2 }
    * method post
    * status 201
    * match response.id == '88'
    * match response.estado == 'creado'
