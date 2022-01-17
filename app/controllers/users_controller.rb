class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :logged_in_user, :correct_user, only: %i(edit update)

  def show
    @pagy, @requests = pagy @user.requests.recent_post
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".please_check_email"
      redirect_to root_url
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::PROPERTIES
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "errors.user.not_found"
    redirect_to root_path
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
