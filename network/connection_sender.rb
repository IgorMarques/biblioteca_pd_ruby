# -*- encoding : utf-8 -*-

require_relative 'TCP_sender'
require_relative 'UDP_sender'

class Connection_sender

  def initialize(port, protocol)
    @port = port
    @protocol = protocol
  end

  def send_message(message)
    if self.protocol == "TCP"
      tcp_sender = TCP_sender.new
      tcp_sender.send_message(port, message)
    elsif self.protocol == "UDP"
      udp_sender = UDP_sender.new
      udp_sender.send_message(port, message)
    else
      puts "Protocolo Inválido!"
    end
  end

end