module BooksHelper
  def load_fill_star book
    book.rate_score.round
  end

  def load_no_fill_star book
    Settings.length.rate - load_fill_star(book)
  end
end
