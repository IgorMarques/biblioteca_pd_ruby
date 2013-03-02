# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../network/connection_manager'
require_relative '../server/client'
require_relative '../network/message'

bibliotecario = Librarian.new("Igor", "password")

origin_port = 7891
destiny_port = 7890
protocol = "TCP"
hostname = "localhost"

client = Client.new(origin_port, bibliotecario)

connection = Connection_Manager.new(destiny_port, protocol, hostname)

message= Message.new("C", "login", ["Igor", "password"])

connection.send_message(message)

puts connection.receive_message

message= Message.new("C", "loan_book", ["Christine", "Huguinho"])

connection.send_message(message)

puts connection.receive_message

message= Message.new("C", "logoff", "Igor")

connection.send_message(message)

puts connection.receive_message

####FALTA ATUALIZAR QUANTIDADE DO LIVRO NO ESTOQUE#####
