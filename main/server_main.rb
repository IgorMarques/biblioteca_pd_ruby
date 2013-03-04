# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'
require_relative '../network/connection_manager'
require_relative '../server/server'

#Instanciadores do "banco de dados"
bibliotecario1 = Librarian.new("Marcia", "password")
bibliotecario2 = Librarian.new("Igor", "password")
bibliotecario3 = Librarian.new("Joaquim", "password")

bibliotecarios = [bibliotecario1, bibliotecario2, bibliotecario3]

livro1 = Book.new("Carrie", 20, 0)
livro2 = Book.new("Christine", 30, 0)
livro3 = Book.new("The Shining", 40, 0)

livros = [livro1, livro2, livro3]

socio1 = Associate.new("Huguinho", [livro1, livro3])
socio2 = Associate.new("Zezinho", [livro2, livro1])
socio3 = Associate.new("Luizinho", livro1)

socios= [socio1,socio2, socio3]

library = Library.new(bibliotecarios,socios,livros)

#fim dos Instanciadores do "banco de dados"

port = 7890
destiny =7889
protocol = "TCP"
hostname = "localhost"

puts "=======SERVIDOR========"

puts "-Porta:"
port= gets.to_i

puts "\n-Criando Servidor"
server = Server.new(port, "" ,library, 2, 7889)

puts "\n-Criando conexão"
#connection = Connection_Manager.new(7889, protocol, hostname)

puts "\n-Notificando aptidão ao Balanceador de Carga"
#server.notify_aptitude(connection)
server.notify_aptitude


puts "\n-Ouvindo clientes"
server.listen(port, protocol)

#server.notify_aptitude(7888)







