class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_likeable, only: %i(create)

  def create
    current_user.like @likeable
    respond_to do |format|
      format.html{redirect_to @likeable}
      format.js
    end
  end

  def destroy
    @like = Like.find_by id: params[:id]
    @likeable = @like.likeable
    current_user.unlike @like
    respond_to do |format|
      format.html{redirect_to @likeable}
      format.js
    end
  end

  private

  def load_likeable
    case params[:likeable_type].to_sym
    when :Book
      @likeable = Book.find_by id: params[:likeable_id]
    when :Author
      @likeable = Author.find_by id: params[:likeable_id]
    end
  end
end
