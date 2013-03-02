# -*- encoding : utf-8 -*-

class Librarian
  attr_reader :username, :password

  def initialize(name, password)
    @username= name
    @password = password
  end

end