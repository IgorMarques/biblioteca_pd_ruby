# -*- encoding : utf-8 -*-

require_relative 'librarian'
require_relative 'associate'
require_relative 'book'
require_relative 'server'
require_relative 'library'

#Instanciadores do "banco de dados"
bibliotecario1 = Librarian.new(9090,"Mayane", "password")
bibliotecario2 = Librarian.new(9090,"Igor", "password")
bibliotecario3 = Librarian.new(9090,"Joaquim", "password")

bibliotecarios = [bibliotecario1, bibliotecario2, bibliotecario3]

livro1 = Book.new("Carrie", 20, 0)
livro2 = Book.new("Christine", 30, 0)
livro3 = Book.new("The Shining", 40, 0)

livros = [livro1, livro2, livro3]

socio1 = Associate.new("Huguinho", livros)
socio2 = Associate.new("Zezinho", "Nenhum")
socio3 = Associate.new("Luizinho", livro1)

socios= [socio1,socio2, socio3]

library = Library.new(bibliotecarios,socios,livros)

#fim dos Instanciadores do "banco de dados"

port = 7890
protocol = "TCP"

server = Server.new(port,"",library)

#server.notify_aptitude(7888)







