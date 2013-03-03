# -*- encoding : utf-8 -*-

require_relative '../network/connection_manager'
require_relative '../server/load_balance'

port = 7889
protocol = "TCP"
hostname = "localhost"

puts "-Criando Balanceador de Carga"
load_balance= Load_Balance.new(port, nil, nil, nil)

puts "-Ouvindo requisições"
load_balance.listen(port, protocol)