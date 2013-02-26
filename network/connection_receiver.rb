# -*- encoding : utf-8 -*-

require_relative 'TCP_receiver'
#require_relative 'UDP_receiver'

class Connection_receiver

  def initialize(port, protocol)
    @port = port
    @protocol = protocol
  end

  def listening
    if protocol == "TCP"
      tcp_receiver = TCP_receiver.new
      tcp_receiver.listening(@port)
    end
  end

end