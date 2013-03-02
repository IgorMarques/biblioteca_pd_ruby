# -*- encoding : utf-8 -*-
#require_relative "chainable"
require_relative "message_handler"

class Logoff_Handler < Message_Handler
  #include Chainable

  def logoff (args)
    params = args[0]
    server = args[1]
    server.validate_logoff(params.join[0..-2])
  end

=begin
  def handle_message(message, server)
    puts "opa"
    if message.host_type == "C" and message.command == "LO"
      server.validate_logoff(message.params.join[0..-2])
    else 
      return false
    end
  end
=end
end