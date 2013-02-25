# -*- encoding : utf-8 -*-
require_relative 'notifier'

class Message_Notifier < Notifier

  include Observable 

  def inicialize()
    add_observer Message_Notifier.new 
  end

  def redirect(message)
    notify_observers(message)
  end
end