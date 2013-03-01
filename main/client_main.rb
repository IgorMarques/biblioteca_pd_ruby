# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../network/connection_manager'
require_relative '../server/client'

bibliotecario = Librarian.new("Igor", "password")

origin_port = 7891
destiny_port = 7890
protocol = "UDP"
hostname = "localhost"

client = Client.new(origin_port, bibliotecario)

connection = Connection_Manager.new(destiny_port, protocol, hostname)

connection.send_message("hello world!")

puts connection.receive_message

loop{

}