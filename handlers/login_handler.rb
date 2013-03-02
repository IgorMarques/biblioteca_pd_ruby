# -*- encoding : utf-8 -*-
#require_relative "chainable"
require_relative "message_handler"

class Login_Handler < Message_Handler
=begin
  include Chainable

  def initialize(link = nil)
    @next = link
  end

  def next_in_chain
    @next
  end
=end

  def login (args)
    params = args[0]
    server = args[1]
    server.validate_login(params[0], params[1][0..-2])
  end 

=begin
  def handle_message(message, server)
    if message.host_type == "C" and message.command == "LI"
      username= message.params[0]
      password= message.params[1][0..-2]
      server.validate_login(username, password)
    else
       handler = Logoff_Handler.new
       handler.handle_message(message, server)
      return false
    end
  end
=end
end