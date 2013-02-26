# -*- encoding : utf-8 -*-

module Chainable

  def next_in_chain(link)
    @next = link
  end

  def method_missing(method, *args, &block)
    if @next == nil
      puts "Mensagem inválida inválido!"
      return
    end
    @next.__send__(method, *args, &block)
  end
end