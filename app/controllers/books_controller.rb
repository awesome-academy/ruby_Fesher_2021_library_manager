class BooksController < ApplicationController
  before_action :load_book, only: %i(show)
  before_action :load_books, only: %i(index)

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @book.comments.recent_post
  end

  def index
    @pagy, @books = pagy @q.result, items: Settings.length.home_items
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
