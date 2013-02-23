class Library

  attr_reader :librarians, :associates, :books
  attr_accessor :librarians, :associates, :books

  def initialize(librarians, associates, books)
    @librarians = librarians
    @associates = associates
    @books = books
  end

  def librarians=(librarians)
    @librarians = librarians
  end

  def associates=(associates)
    @associates = associates
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