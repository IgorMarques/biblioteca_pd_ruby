# -*- encoding : utf-8 -*-
class Associate
  attr_reader :name, :books
  attr_accessor :name, :books

  def initialize(name, books)
    @name= name  
    @books= books  
  end

  def name=(name)
    @name = name
  end

  def books=(books)
    @books = books
  end
end