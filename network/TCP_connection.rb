# -*- encoding : utf-8 -*-

require 'socket' 

class TCP_sender 

  def initialize (port, hostname)
    @socket = TCPSocket.open(hostname, port)
  end

  def send_message (message)
    self.socket.puts message.to_string
  end

  def receive_message
    message self.socket.gets 
    ##REPASSAR A MSG##
  end

  def listen
  end

  def close
     self.socket.close 
  end

end
