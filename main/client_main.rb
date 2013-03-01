# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../network/connection_manager'
require_relative '../server/client'

bibliotecario = Librarian.new("Igor", "password")

port = 7891
protocol = "TCP"
hostname = "localhost"

client = Client.new(port, bibliotecario)

connection = Connection_Manager.new(port, protocol, hostname)

connection.send_message("hello world!")