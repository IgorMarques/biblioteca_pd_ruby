# -*- encoding : utf-8 -*-

require_relative 'librarian'
require_relative 'associate'
require_relative 'book'

class Server

  attr_reader :librarians, :associates, :online_clients, :book_collection
  attr_accessor :librarians

  #construtor
  def initialize(librarians, associates, online_clients, book_collection)
    @librarians = librarians
    @associates = associates
    @online_clients = online_clients
    @book_collection = book_collection

  end

  def librarians=(librarians)
    @librarians = librarians
  end

  def associates=(associates)
    @associates = associates
  end

  def online_clients=(online_clients)
    @online_clients = online_clients 
  end

  def book_collection=(book_collection)
    @book_collection = book_collection
  end

  def new_librarian(librarian)
    for i in 0..librarians.length
      if librarians[i].name == librarian.name
        return false
      end      
    end
    @librarians << librarian
    return true
  end

  def new_book(book)
    for i in 0..librarians.length
      if book_collection[i].title == book.title
        return false
      end      
    end
    @book_collection << book
    return true
  end
end

