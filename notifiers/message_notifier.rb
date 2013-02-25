# -*- encoding : utf-8 -*-
require_relative 'notifier'

class Message_Notifier < Notifier

  include Observable 

  def inicialize()
  end

  def redirect(message)
    notify_observers(message)
  end
end