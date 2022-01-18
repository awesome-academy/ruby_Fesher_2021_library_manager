class AuthorsController < ApplicationController
  before_action :load_author

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @author.comments.recent_post
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
