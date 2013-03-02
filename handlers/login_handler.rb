# -*- encoding : utf-8 -*-
#require_relative "chainable"
require_relative "message_handler"

class Login_Handler < Message_Handler

  def login (args)
    params = args[0]
    server = args[1]
    client = args[2]
    server.validate_login(params[0], params[1][0..-2], client)
  end 

end