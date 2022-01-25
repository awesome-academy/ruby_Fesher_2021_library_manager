class AuthorsController < ApplicationController
  before_action :load_author, only: :show
  before_action :force_json, only: :search

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @author.comments.recent_post
  end

  def search
    q = params[:q].downcase
    @author = Author.like_name(q).limit(Settings.length.item_limit)
  end

  private

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author

    flash[:danger] = t ".not_found"
    redirect_to root_url
  end

  def force_json
    request.format = :json
  end
end
