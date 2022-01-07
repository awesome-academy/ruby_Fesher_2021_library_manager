class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: %i(new)
  before_action :load_request, except: %i(index new create)
  before_action :check_status, only: %i(update)

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

  def index
    @pagy, @requests = pagy Request.recent_post
  end

  def show; end

  def update
    if (@request.status.to_sym == :fresh) &&
       @request.update(status: params[:request][:status])
      Book.find_by(id: @request.book_id).returned_book
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to user_path current_user
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

  def load_request
    @request = Request.find_by id: params[:id]
    return if @request

    flash[:danger] = t ".load_fail"
    redirect_to admin_root_path
  end

  def check_status
    return unless params[:request][:status].to_sym != :client_rejected

    flash[:danger] = t ".fail"
    redirect_to user_path current_user
  end
end
