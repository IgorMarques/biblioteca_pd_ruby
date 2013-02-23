# -*- encoding : utf-8 -*-
class Librarian
  attr_reader :name, :password
  attr_accessor :name, :password

  def initialize(name, password)
    @name= name
    @password = password
  end

  def name=(name)
    @name = name
  end

  def password=(password)
    @password = password
  end
end