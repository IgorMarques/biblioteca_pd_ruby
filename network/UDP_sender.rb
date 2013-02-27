# -*- encoding : utf-8 -*-

require 'socket'

class UDP_sender

###FALTA ARRUMAR

  def send_message(port, message)

    s = UDPSocket.new

    s.send(message.to_string, 0, 'localhost', port)

  end

end


