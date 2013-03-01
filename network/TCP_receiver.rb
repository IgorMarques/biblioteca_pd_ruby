# -*- encoding : utf-8 -*-

require 'socket' 
require_relative '../notifiers/message_notifier.rb'
require 'observer'

class TCP_receiver

  include Observable 

  def inicialize(port)
    socket = TCPServer.open(port) 
    add_observer Connection_manager.new 
  end

  def listening
    loop {
      Thread.start(self.socket.accept) do |client| #abre uma thread para um cliente quando recebe solicitacao

        connection = Connection_Manager.new(port, protocol, hostname)

        while line = client.gets  #enquanto estiver ouvindo

          message= Message.new
          
          message.string_to_message(line)

          ###PROCESSAR MENSAGENS POR MAGIA####

          #notify_observers(message)
          
        end
        client.close               
      end
    }
  end

end
