require_relative "TCP_receiver"
require_relative "TCP_sender"


receiver = TCP_receiver.new

receiver.listening(2000)
