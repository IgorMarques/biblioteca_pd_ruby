# -*- encoding : utf-8 -*-

require_relative "message_handler"

class Request_Login_Handler < Message_Handler

  def request_login(args)
    params = args[0]
    load_balance = args[1]
    client = args[2]

    load_balance.request_login(params.join[0..-1], client)
  end
  
end