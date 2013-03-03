# -*- encoding : utf-8 -*-
# -*- encoding : utf-8 -*-

require_relative '../handlers/aptitude_handler'
require_relative '../handlers/request_login_handler'
require_relative '../network/message'
#require_relative '../handlers/logoff_handler'
#require_relative '../handlers/loan_book_handler'

class Load_Balance

  attr_reader :port, :servers, :able_servers, :client_list

  #construtor
  def initialize(port, online_servers, able_servers, client_list)
    @port = port
    @servers = []
    @able_servers = []
    @client_list = []
  end

  def listen(port, protocol)

    if protocol === "TCP"

      server_socket = TCPServer.open(self.port) 

       loop {
        Thread.start(server_socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

          while line = client.gets  #enquanto estiver ouvindo

            message= Message.new
            
            message.string_to_message(line)

            handler = Apitude_Handler.new(Request_Login_Handler.new)

            handler.handle_massage(message.command, [message.params, self, client])
      
          end
          #client.close               
        end
      }

      elsif protocol == "UDP"
        puts "procotolo UDP ainda não implementado"
      end
    
  end
  def request_login(port, client)
    puts"-Cliente solicitando servidor"
    client.puts self.able_servers[0]
    puts"--Cliente atendido"
  end

  def check_server_down()
  end

  def update_able_servers(port, server)
    self.able_servers.push(port)
    puts "-Servidor de porta #{port} adicionado com sucesso a lista de servidores ativos"
    server.puts "~> Você foi adicionado com sucesso a lista de servidores ativos do LB."

  end

  def add_new_server(port, server)  
    self.servers.push(port)
    puts "-Servidor de porta #{port} adicionado com sucesso a lista de servidores"
    server.puts "~> Você foi adicionado com sucesso a lista de servidores do LB."
    self.update_able_servers(port, server)
  end

end