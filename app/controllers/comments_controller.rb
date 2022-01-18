class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment_build
    @comment_build.save
    @commentable = @comment_build.commentable
    @pagy, @comments = pagy @commentable.comments.recent_post
    @comment = Comment.new
    respond_to do |format|
      format.html{redirect_to @commentable}
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit Comment::PROPERTIES
  end

  def comment_build
    @comment_build = current_user.comments.build comment_params
  end
end
