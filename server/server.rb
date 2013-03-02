# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'
require_relative '../handlers/login_handler'
require_relative '../handlers/logoff_handler'

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

            handler = Login_Handler.new(Logoff_Handler.new)#(Loan_Handler.new(Devolution_Handler.new(Inform_Books.new))))

            handler.handle_massage(message.command, [message.params, self])
      
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

  def validate_login(username, password)

    puts  "-Validando login do usuário #{username}"

    librarians = @library.librarians

    librarians.each do |librarian|

      if (librarian.username == username) and (librarian.password == password)
 
        online_clients= @online_clients

        online_clients.each do |client|
          if client.username == username
            puts "-Usuário #{username} já está conectado. Recusando login"
            return false
          end
        end
        
        self.online_clients.push(Librarian.new(username, password))
        puts "--Novo cliente conectado! Username: #{username}, Senha: #{password}"
        return 
        ###FALTA RESPONDER
      end
    end

    puts "--Usuário Username: #{username}, Senha: #{password} não existe no sistema."
  end

  def validate_logoff(username)
    remove_online_client(username)  
  end

  def validate_loan(book, associate)
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

