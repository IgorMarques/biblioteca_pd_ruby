# -*- encoding : utf-8 -*-
require 'socket' 
require_relative 'message'
require_relative 'connection_receiver'
#require_relative 'network/connection_sender'

def Connection_Manager

  def star_listening
    receiver = Connection_receiver.new(port, protocol)

    listener = Thread.new {
      receiver.listening
    }
  end

end

