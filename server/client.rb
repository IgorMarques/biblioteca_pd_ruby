# -*- encoding : utf-8 -*-

require_relative 'librarian'

class Client

  attr_reader :port, :librarian
  attr_accessor :port, :librarian

  #construtor
  def initialize(port, librarian)
    @port = port
    @librarian = librarian

  end

  def login (server)
  end

  def logoff
  end

  def update_amout(amount, book)
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

