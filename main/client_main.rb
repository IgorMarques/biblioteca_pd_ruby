# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../network/connection_manager'
require_relative '../server/client'
require_relative '../network/message'

puts "=======CLIENTE========"

puts "--Opções: \n<1> Usuário padrão \n<2> Usuário informado"
option= gets.to_i

if option == 1
  username= "Igor"
  password= "password"
  origin_port= 7891
  protocol = "TCP"
elsif option == 2
  puts"- Porta:"
  origin_port = gets.to_i 
  puts"- Nome de usuário:"
  username = gets 
  username = username[0..-2]
  puts"- Senha:"
  password = gets 
  puts"- Protocolo:"
  protocol = "TCP"
end


bibliotecario = Librarian.new(username, password)

#origin_port = 7891
destiny_port = 7889

hostname = "localhost"
book = "Christine"
associate= "Huguinho"

puts "-Criando Cliente"
client = Client.new(origin_port, bibliotecario, destiny_port)

puts "-Criando conexão"
connection = Connection_Manager.new(client.destiny_port, protocol, hostname)

puts "-Criando solicitando servidor ao Balanceador de Carga"
client.request_login(connection)

puts "-Conectando ao servidor informado"
connection = Connection_Manager.new(client.destiny_port, protocol, hostname)

puts "-Logando bibliotecário"
client.login(connection, bibliotecario.username, bibliotecario.password)

puts "-Relizando empréstimo"
client.loan_book(connection, book, associate)

puts "\n-Pressiona qualquer tecla para fazer logoff."
loop{
  if gets
    puts "-Fazendo logoff"
    client.logoff(connection, bibliotecario.username)
    break
  end
}

puts "==Fim=="
