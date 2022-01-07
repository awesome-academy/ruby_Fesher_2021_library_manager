class BooksController < ApplicationController
  before_action :load_book

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @book.comments.recent_post
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
