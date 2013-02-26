# -*- encoding : utf-8 -*-

require 'socket' 
require_relative 'message'
require_relative 'connection_receiver'
require "singleton"  
#require_relative 'network/connection_sender'

def Connection_Manager

  include Singleton

  def star_listening
    receiver = Connection_receiver.new(port, protocol)

    listener = Thread.new {
      receiver.listening
    }
  end

  def message_received(message)
    ###manipula a mensagem
  end

end

