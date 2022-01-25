class BooksController < ApplicationController
  before_action :load_books, only: %i(index)
  load_and_authorize_resource

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @book.comments.recent_post
  end

  def index
    @pagy, @books = pagy @q.result, items: Settings.length.home_items
  end
end
