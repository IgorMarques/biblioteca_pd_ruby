# -*- encoding : utf-8 -*-

require_relative '../system/librarian'

class Client

  attr_reader :port, :librarian, :destiny_port
  attr_accessor :port, :librarian, :destiny_port

  #construtor
  def initialize(port, librarian, destiny_port)
    @port = port
    @librarian = librarian
    @destiny_port = destiny_port
  end

  def request_login(connection)
    message= Message.new("C", "request_login","0")
    connection.send_message(message)
    @destiny_port= connection.receive_message[0..-2]
  end

  def login (connection, login, senha)

    message= Message.new("C", "login", [login, senha])

    connection.send_message(message)

    puts connection.receive_message
  end

  def logoff(connection, username)
    message= Message.new("C", "logoff", username)

    connection.send_message(message)

    puts connection.receive_message
  end

  def update_amout(amount, book)
  end

  def loan_book(connection, book, associate)
    message= Message.new("C", "loan_book", [book, associate])

    connection.send_message(message)

    puts connection.receive_message
  end

  def inform_books_associate(connection, associate)
    message= Message.new("C", "inform_books", associate)

    connection.send_message(message)

    puts connection.receive_message
    puts connection.receive_message
    puts connection.receive_message
    puts connection.receive_message

  end

  def return_book_associate(connection, book, associate)


  end

  def return_book(connection, associate)
    puts "--Realizando devolução de livro"
    puts "---Verificando livros em posse do usuário #{associate}"
    self.inform_books_associate(connection, associate)

    puts "--Informe o livro que deseja retornar"
    book = gets 

    puts "---Devolvendo livro #{book}"

    message= Message.new("C", "return_book", [associate, book])

    connection.send_message(message)

    puts connection.receive_message
  end

end

