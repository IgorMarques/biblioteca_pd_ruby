# -*- encoding : utf-8 -*-

require_relative '../system/librarian'
require_relative '../system/associate'
require_relative '../system/book'
require_relative '../system/library'

class Server

  attr_reader :port, :online_clients, :library
  attr_accessor :port, :online_clients, :library

  #construtor
  def initialize(port, online_clients="", library="")
    @port = port
    @online_clients = online_clients
    @library = library

  end

  def online_clients=(online_clients)
    @online_clients = online_clients 
  end

  def validate_login(librarian)
  end

  def validate_logoff(librarian)
  end

  def validate_loan(book, associate)
  end

  def validade_devolution(book, associate)
  end

  def inform_books_associate(associate)
  end

  def get_backup()
  end

  def notify_aptitude()
  end

  def notify_overload()
  end

  def notify_shutdown()
  end
end

