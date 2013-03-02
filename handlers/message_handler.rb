require_relative "chainable"

class Message_Handler
  include Chainable

=begin
  def initialize(link = nil)
    next_in_chain(link)
  end
=end

  def initialize(link = nil)
    @next = link
  end

  def next_in_chain
    @next
  end
  
end
