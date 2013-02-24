# -*- encoding : utf-8 -*-
class Librarian
  attr_reader :port, :name, :password

  def initialize(port, name, password)
    @port = port
    @name= name
    @password = password
  end

end