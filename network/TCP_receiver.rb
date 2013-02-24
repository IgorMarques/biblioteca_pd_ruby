require 'socket' 

class TCP_receiver

  def listening(port)
    socket = TCPServer.open(port) 
    loop {
      Thread.start(socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

        while line = client.gets  #enquanto estiver ouvindo

          message= Message.new
          
          message.string_to_message(line)
          
        end
        client.close               
      end
    }
  end

end
