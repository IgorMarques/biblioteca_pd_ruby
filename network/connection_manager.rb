# -*- encoding : utf-8 -*-

require 'socket' 
require_relative 'message'
require_relative 'connection_receiver'
require "singleton"  
#require_relative 'network/connection_sender'

class Connection_Manager

  include Singleton

  def inicialize(port, protocol) 
    @port=port
    @protocol=protocol
  end
  
  def listen
    receiver = Connection_receiver.new(@port, @protocol)
    
    receiver.listening
    
  end

  def message_received(message)
    ###manipula a mensagem
  end

end

