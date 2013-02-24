require_relative "TCP_receiver"
require_relative "TCP_sender"
require_relative "message.rb"


sender = TCP_sender.new

vetor= "param1", "param2" 

message = Message.new("c", "ba", vetor )

sender.send_message(2000, message)
