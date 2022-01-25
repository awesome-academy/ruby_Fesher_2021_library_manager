class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @pagy, @requests = pagy @user.requests.recent_post
  end
end
