# -*- encoding : utf-8 -*-
class Book
  attr_reader :title, :total_amount, :lent_amount
  attr_accessor :title, :total_amount, :lent_amount

  def initialize(title, total_amount, lent_amount)
    @title= title
    @total_amount = total_amount
    @lent_amount = lent_amount
  end

  def title=(title)
    @title = title
  end

  def total_amount=(amount)
    @total_amount = amount
  end

  def lent_amount=(amount)
    @lent_amount = amount
  end

  def stock_amount
    @total_amount - @lent_amount
  end

end