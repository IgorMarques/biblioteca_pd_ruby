# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'
require_relative '../handlers/login_handler'
require_relative '../handlers/logoff_handler'
require_relative '../handlers/loan_book_handler'
require_relative '../network/message'

class Server

  attr_reader :port, :online_clients, :library
  attr_accessor :port, :online_clients, :library

  #construtor
  def initialize(port, online_clients=nil, library="")
    @port = port
    @online_clients = []
    @library = library

  end

  def remove_online_client(username)

    @online_clients.each do |client| 

      if client.username == username
        @online_clients.delete(client)
        puts "--Usuário #{username} fez logoff."
        return true
      end

    end

    return false

  end

  def listen(port, protocol)

    if protocol === "TCP"

      server_socket = TCPServer.open(self.port) 

       loop {
        Thread.start(server_socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

          while line = client.gets  #enquanto estiver ouvindo

            message= Message.new
            
            message.string_to_message(line) 

            handler = Login_Handler.new(Logoff_Handler.new(Loan_Book_Handler.new))#(Devolution_Handler.new(Inform_Books.new))))

            handler.handle_massage(message.command, [message.params, self, client])
      
          end
          #client.close               
        end
      }
      elsif protocol == "UDP"

        client = UDPSocket.new
        client.bind('0.0.0.0', @port)
        loop{
          data, addr = client.recvfrom(@port) 
          
          message= Message.new
            
          message.string_to_message(data) 

          handler = Login_Handler.new(Logoff_Handler.new(Loan_Book_Handler.new))#(Devolution_Handler.new(Inform_Books.new))))

          handler.handle_massage(message.command, [message.params, self, client])
      
        }
      else 
        puts "--Protocolo inválido!--"
      end
  end

  def validate_login(username, password, client)

    puts  "-Validando login do usuário #{username}"

    librarians = @library.librarians

    librarians.each do |librarian|

      if (librarian.username == username) and (librarian.password == password)
 
        online_clients= @online_clients

        online_clients.each do |client|
          if client.username == username
            puts "--Usuário #{username} já está conectado. Recusando login"
            client.puts "=> O usuário #{username} já está conectado! Tente login com outro usuário!"
            return false
          end
        end
        
        self.online_clients.push(Librarian.new(username, password))
        puts "--Novo cliente conectado! Username: #{username}, Senha: #{password}"
        client.puts "=> Você foi conectado com sucesso!"
        return 
        ###FALTA RESPONDER
      end
    end

    puts "--Usuário Username: #{username}, Senha: #{password} não existe no sistema."
    client.puts "=> Usuário Username: #{username}, Senha: #{password} não existe no sistema."

  end

  def validate_logoff(username, client)
    puts "--Tentando realizar logoff do usuário #{username}"

    if remove_online_client(username)
      client.puts "=> Logoff realizado com sucesso." 
    else
      client.puts "=> Logoff nao pode ser realizado com sucesso." 
    end 
  end

  def validate_loan(book, associate, client)
    puts "-Tentando realizar empréstimo do livro: #{book} ao sócio: #{associate}"
    i=0
    self.library.books.each do |library_book| 

     

      if library_book.title == book

        if library_book.stock_amount > 0

          self.library.associates.each do |library_associate|

            if library_associate.name == associate
    
              new_amount= @library.books[i].lent_amount + 1
              @library.books[i].lent_amount = new_amount

              puts "--Emprestimo feito"
              puts "--A quantidade do livro #{book} disponível para empréstimo agora é #{@library.books[i].stock_amount}"
              client.puts "=> Empréstimo feito com sucesso! A quantidade do livro #{book} disponível para empréstimo agora é #{@library.books[i].stock_amount}"
             return
            end

            puts "-O sócio #{associate} não está cadastrado."
            client.puts "=> O sócio #{associate} não está cadastrado!"
            return
          end
        else
          puts "--Quantidade de livros em estoque insuficientes para completar o empréstimo."
          client.puts "=> O empréstimo não pode ser realizado. Quantidade de livros em estoque insuficientes para completar o empréstimo."
          return
        end

      end

    i= i+1
    end

    puts "-O livro #{book} não existe no acervo."
    client.puts "=> O livro #{book} não existe no acervo!"
    return

  end

  def validade_devolution(book, associate)
  end

  def inform_books_associate(associate)
  end

  def get_backup()
  end

  def notify_aptitude(port, connection)
    message = Message.new("S","notify_apitude",port)
    connection.send_message(message)
  end

  def notify_overload()
  end

  def notify_shutdown()
  end
end

