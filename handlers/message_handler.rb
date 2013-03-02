require_relative "chainable"

class Message_Handler
  include Chainable

  def initialize(link = nil)
    @next = link
  end

  def next_in_chain
    @next
  end
  
end
