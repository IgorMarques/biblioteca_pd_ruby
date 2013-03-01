# -*- encoding : utf-8 -*-

require 'socket'

class UDP_connection

  def initialize (port)
    @socket = UDPSocket.new
    @port= port
  end

  def send_message(message)
    @socket.send(message, 0, '127.0.0.1', @port)
  end

  def receive_message
    @socket.recvfrom(@port)
  end

  def close
     @socket.close 
  end
end