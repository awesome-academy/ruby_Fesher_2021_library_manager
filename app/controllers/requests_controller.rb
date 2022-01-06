class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: %i(new)

  def new
    @request = current_user.requests.build
    @request.book_id = @book.id
  end

  def create
    request_build
    if @request.save
      @book.requested_book
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".fail"

      render :new
    end
  end

  private
  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book

    flash[:danger] = t ".book"
    redirect_to root_path
  end

  def request_params
    params.require(:request).permit Request::PROPERTIES
  end

  def request_build
    @request = current_user.requests.build request_params
    @book = @request.book
  end
end
