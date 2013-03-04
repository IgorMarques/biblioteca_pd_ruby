# -*- encoding : utf-8 -*-
require_relative "message_handler"

class Inform_Book_Handler < Message_Handler

  def inform_books (args)
    params = args[0]
    server = args[1]
    client = args[2]

    server.inform_books_associate(params.join[0..-2], client)
  end
end