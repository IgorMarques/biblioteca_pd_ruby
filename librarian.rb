# -*- encoding : utf-8 -*-
class Librarian
  attr_reader :name, :password

  def initialize(name, password)
    @name= name
    @password = password
  end

end