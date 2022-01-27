class Admin::BooksController < AdminsController
  load_and_authorize_resource except: %i(delete_image_attachment)

  def index
    @pagy, @books = pagy Book.recent_added
  end

  def new; end

  def create
    @book = Book.new book_params
    @book.images.attach params[:book][:images] if params[:book][:images]
    if @book.save
      flash[:success] = t ".success"
      redirect_to [:admin, @book]
    else
      flash.now[:danger] = t ".fail"
      render :new
    end
  end

  def show
    @pagy, @comments = pagy @book.comments.recent_post
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      @book.images.attach params[:book][:images] if params[:book][:images]
      if @book.update book_params
        flash[:success] = t ".success"
        redirect_to [:admin, @book]
      else
        flash.now[:danger] = t ".fail"
        render :edit
      end
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t ".success"
    else
      flash.now[:danger] = t ".fail"
    end
    redirect_to admin_books_path
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find_by id: params[:id]
    return redirect_to admin_books_path unless @image

    @image.purge
    @book = Book.find_by id: @image.record_id
    return redirect_to admin_books_path unless @book

    respond_to do |format|
      format.html{redirect_to @book}
      format.js
    end
  end

  private

  def book_params
    params.require(:book).permit Book::PROPERTIES
  end
end
