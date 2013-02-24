require 'socket' 
require 'json'
require_relative "message.rb"

class TCP_sender

  def send_message (port, message)
    hostname = 'localhost'

    s = TCPSocket.open(hostname, port)

    s.puts message.to_string

    s.close 

  end

end
