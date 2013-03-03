# -*- encoding : utf-8 -*-

require_relative "message_handler"

class Apitude_Handler < Message_Handler

  def notify_apitude (args)
    params = args[0]
    load_balance = args[1]
    client = args[2]

    load_balance.add_new_server(params.join[0..-1], client)
  end
  
end