# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'
require_relative '../handlers/login_handler'
require_relative '../handlers/logoff_handler'
require_relative '../handlers/loan_book_handler'

class Server

  attr_reader :port, :online_clients, :library
  attr_accessor :port, :online_clients, :library

  #construtor
  def initialize(port, online_clients=nil, library="")
    @port = port
    @online_clients = []
    @library = library

  end

  def remove_online_client(username, client)

    @online_clients.each do |user| 

      if user.username == username
        @online_clients.delete(user)
        puts "--Usuário #{username} fez logoff."
        client.puts "=> Você fez logoff com sucesso!"
      end
    end

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

        ##falta implementar multithread##
        client = UDPSocket.new
        client.bind('0.0.0.0', @port)
        data, addr = client.recvfrom(@port) # if this number is too low it will drop the larger packets and never give them to you
        
        puts data

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
    remove_online_client(username, client)  
  end

  def validate_loan(book, associate, client)
    puts "--Tentando realizar empréstimo do livro: #{book} ao sócio: #{associate}"
    
    self.library.books.each do |library_book| 

      if library_book.title == book

        self.library.associates.each do |library_associate|

          if library_associate.name == associate
            puts "Emprestimo feito"
            client.puts "=> Empréstimo feito!"
            return
          end

        puts "-O sócio #{associate} não está cadastrado."
        client.puts "=> O sócio #{associate} não está cadastrado!"
        return

        end

      end
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

  def notify_aptitude()
  end

  def notify_overload()
  end

  def notify_shutdown()
  end
end

