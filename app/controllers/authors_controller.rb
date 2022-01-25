class AuthorsController < ApplicationController
  before_action :force_json, only: :search
  load_and_authorize_resource

  def show
    @comment = Comment.new
    @pagy, @comments = pagy @author.comments.recent_post
  end

  def search
    q = params[:q].downcase
    @author = Author.like_name(q).limit(Settings.length.item_limit)
  end

  private

  def force_json
    request.format = :json
  end
end
