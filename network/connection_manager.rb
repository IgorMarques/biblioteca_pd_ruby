# -*- encoding : utf-8 -*-

require 'socket' 
require_relative 'message'
require_relative 'TCP_connection'
require_relative 'UDP_connection'

class Connection_Manager

  def initialize(port, protocol, hostname) 
    @port=port
    @protocol=protocol
    if protocol == "TCP"
      @connection = TCP_connection.new(port, hostname)
    elsif protocol == "UDP"
      @connection = UDP_connection.new(port)
    end
  end

  def send_message(message)
    @connection.send_message(message)
  end

  def listen
    @connection.listen    
  end

  def receive_message
    @connection.receive_message
  end

  def close
    @connection.close
  end

end

