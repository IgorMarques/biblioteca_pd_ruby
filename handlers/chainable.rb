# -*- encoding : utf-8 -*-

module Chainable

  def next_in_chain
    nil
  end

  def handle_massage(method, *args, &block)
    puts "opaa"
    if self.respond_to?(method)
      puts "entrando no handle_message do Chainable"
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