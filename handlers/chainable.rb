# -*- encoding : utf-8 -*-

module Chainable

  def next_in_chain
    nil
  end

  def handle_massage(method, *args, &block)

    if self.respond_to?(method)

      self.__send__(method, *args, &block)
    else
      if next_in_chain.nil?
        puts "Mensagem inválida!"
      else
        next_in_chain.handle_massage(method, *args, &block)
      end
    end
  end

end