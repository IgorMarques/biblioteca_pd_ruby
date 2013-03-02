# -*- encoding : utf-8 -*-

require 'socket' 

class TCP_connection

  def initialize (port, hostname)
    @socket = TCPSocket.open(hostname, port)
  end

  def send_message(message)
    @socket.puts message.to_string
  end

  def receive_message
    @socket.gets 
  end

=begin
  def listen
     server_socket = TCPServer.open(self.port) 

     loop {
      Thread.start(self.server_socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

        while line = client.gets  #enquanto estiver ouvindo

          message= Message.new
          
          message.string_to_message(line)

          #notify_observers(message)

          puts message
          
        end
        client.close               
      end
    }

  end
=end
  def close
     @socket.close 
  end

end
