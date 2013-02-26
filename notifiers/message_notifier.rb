# -*- encoding : utf-8 -*-

require_relative 'notifier'

class Message_Notifier < Notifier

  include Observable 

  def inicialize()
    add_observer Connection_Manager.instance
  end

  def redirect(message)
    notify_observers(message)
  end
end

