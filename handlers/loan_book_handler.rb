# -*- encoding : utf-8 -*-
require_relative "message_handler"

class Loan_Book_Handler < Message_Handler

  def loan_book (args)
    params = args[0]
    server = args[1]
    client = args[2]
    server.validate_loan(params[0][0..-1], params[1][0..-2], client)
  end

end