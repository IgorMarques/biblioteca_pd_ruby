# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'
require_relative '../handlers/login_handler'
require_relative '../handlers/logoff_handler'
require_relative '../handlers/loan_book_handler'
require_relative '../handlers/inform_book_handler'
require_relative '../handlers/return_book_handler'
require_relative '../network/message'
require_relative '../network/connection_manager'


class Server

  #@connection = Connection_Manager.new(7889, protocol, hostname)

  attr_reader :port, :online_clients, :library
  attr_accessor :port, :online_clients, :library, :max_clients

  #construtor
  def initialize(port, online_clients=nil, library="", max_clients, lb)
   
    destiny =7889
    protocol = "TCP"
    hostname = "localhost"

    @port = port
    @online_clients = []
    @library = library
    @max_clients = max_clients
    @load_balance = lb
    @connection = Connection_Manager.new(7889, protocol, hostname)

  end

  def notify_aptitude#(connection)
    message = Message.new("S","notify_apitude",port.to_s)
    @connection.send_message(message)

    puts  @connection.receive_message
    puts  @connection.receive_message
  end

  def notify_overload()

    message = Message.new("S","notify_overload", port.to_s)
    
    @connection.send_message(message)

    puts @connection.receive_message

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

            #print message.params

            handler = Login_Handler.new(Logoff_Handler.new(Loan_Book_Handler.new(Inform_Book_Handler.new(Return_Book_Handler.new))))

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

          handler = Login_Handler.new(Logoff_Handler.new(Loan_Book_Handler.new(Inform_Book_Handler.new(Return_Book_Handler.new))))#(Devolution_Handler.new(Inform_Books.new))))

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
            puts "--Usuário #{username} já está conectado. Recusando login\n"
            client.puts "=> O usuário #{username} já está conectado! Tente login com outro usuário!"
            return false
          end
        end
        


        self.online_clients.push(Librarian.new(username, password))
        puts "--Novo cliente conectado! Username: #{username}, Senha: #{password}\n"
        
        puts "\n-Clientes conectados: " 
        puts online_clients.length 

        if online_clients.length == @max_clients
          self.notify_overload()
        end

        client.puts "=> Você foi conectado com sucesso!"
        return 
        
      end
    end

    puts "--Usuário Username: #{username}, Senha: #{password} não existe no sistema.\n"
    client.puts "=> Usuário Username: #{username}, Senha: #{password} não existe no sistema."

  end

  def validate_logoff(username, client)
    puts "-Tentando realizar logoff do usuário #{username}"

    if remove_online_client(username)
      client.puts "=> Logoff realizado com sucesso." 
    else
      client.puts "=> Logoff nao pode ser realizado com sucesso." 
    end 
  end

  def loan_book(associate, book)
  
   i=0

   self.library.associates.each do |lib_associate|

    if lib_associate.name == associate

      new_book = Book.new(book,0,0)

      self.library.associates[i].books.push(new_book)
    end

    i= i+1

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

              self.loan_book(associate, book)

              puts "--Emprestimo feito"
              puts "--A quantidade do livro #{book} disponível para empréstimo agora é #{@library.books[i].stock_amount}\n"
              client.puts "=> Empréstimo feito com sucesso! A quantidade do livro #{book} disponível para empréstimo agora é #{@library.books[i].stock_amount}"
             return
            end

            puts "-O sócio #{associate} não está cadastrado.\n"
            client.puts "=> O sócio #{associate} não está cadastrado!"
            return
          end
        else
          puts "--Quantidade de livros em estoque insuficientes para completar o empréstimo.\n"
          client.puts "=> O empréstimo não pode ser realizado. Quantidade de livros em estoque insuficientes para completar o empréstimo."
          return
        end

      end

    i= i+1
    end

    puts "-O livro #{book} não existe no acervo.\n"
    client.puts "=> O livro #{book} não existe no acervo!"
    return
  end

  def validade_devolution(book, associate)
  end

  def inform_books_associate(associate, client)

    i=0

    resultado = []

    self.library.associates.each do |lib_associate|

      if lib_associate.name == associate

        self.library.associates[i].books.each do |book|

          resultado << book.title
        end

      end

    i= i+ 1
    end 

    client.puts "=>O sócio #{associate} possui os seguintes livros em posse" 

    client.puts resultado

  end

  def return_book(associate, book, client)

    puts "-Devolvendo livro #{book} locado por #{associate}"
    i=0
    self.library.associates.each do | lib_associate |

      if lib_associate.name == associate
              
          lib_associate.books.each do |a_book| 
                  
            if a_book.title == book
            
              new_book = Book.new(book, 0, 0)
            
              @library.associates[i].books.delete(new_book)

              puts "--Livro devolvido com sucesso!"

              client.puts "=> Livro devolvido com sucesso!"
            end

          end

      end

      i=i+1
    end 
  end

  def get_backup()
  end

  def notify_shutdown()
  end
end

