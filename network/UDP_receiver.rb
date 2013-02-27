# -*- encoding : utf-8 -*-

require 'socket'
require_relative '../notifiers/message_notifier.rb'
require 'observer'

###FALTA ARRUMAR
###FALTA ARRUMAR
###FALTA ARRUMAR

class UDP_receiver

  include Observable 

  def inicialize()
    add_observer Message_Notifier.new 
  end

  def listening(port)

    client = UDPSocket.new

    loop{
      client.bind('127.0.0.0', port)
      line= client.recvfrom(port)

      message= Message.new
      
      message.string_to_message(line)

      notify_observers(message)
    }
    client.close

  end

end

