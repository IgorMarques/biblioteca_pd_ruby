class Message_Handler
  include Chainable

  def initialize(link = nil, message)
    next_in_chain(link)
    @message = message
  end

end
