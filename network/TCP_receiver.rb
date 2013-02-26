# -*- encoding : utf-8 -*-

require 'socket' 
require_relative '../notifiers/message_notifier.rb'
require 'observer'

class TCP_receiver

  include Observable 

  def inicialize()
    add_observer Message_Notifier.new 
  end

  def listening(port)
  socket = TCPServer.open(port) 
    loop {
      Thread.start(socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

        while line = client.gets  #enquanto estiver ouvindo

          message= Message.new
          
          message.string_to_message(line)

          notify_observers(message)
          
        end
        client.close               
      end
    }
  end

end
