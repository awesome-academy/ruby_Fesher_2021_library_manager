class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper
  include Pagy::Backend

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
