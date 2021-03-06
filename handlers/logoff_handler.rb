# -*- encoding : utf-8 -*-

require_relative "message_handler"

class Logoff_Handler < Message_Handler

  def logoff (args)
    params = args[0]
    server = args[1]
    client = args[2]
    server.validate_logoff(params.join[0..-2], client)
  end
  
end