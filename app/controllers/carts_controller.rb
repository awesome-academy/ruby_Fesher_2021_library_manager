class CartsController < ApplicationController
  def index
    load_books
  end

  def create
    load_book
    return unless @book.quantity.positive?

    session[:cart].push @book.id unless book_in_cart?(@book.id)
  end

  def destroy
    session[:cart].delete params[:id].to_i
    load_books
  end

  private

  def book_in_cart? id
    session[:cart].include?(id)
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book

    flash[:danger] = t ".fail"
    redirect_to root_path
  end

  def load_books
    @books = Book.find_for_cart session[:cart]
  end
end
