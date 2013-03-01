# -*- encoding : utf-8 -*-

require 'socket' 
require_relative 'message'
require_relative 'TCP_connection'

class Connection_Manager

  def initialize(port, protocol, hostname) 
    @port=port
    @protocol=protocol
    if protocol == "TCP"
      @connection = TCP_connection.new(port, hostname)
    end
  end

  def send_message(message)
    self.connection.send_message(message)
  end

  def listen
    self.connection.listen    
  end

  def receive_message(message)
    self.connection.receive_message
  end

  def close
    self.connection.close
  end

end

