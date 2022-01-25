class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::PROPERTIES
    devise_parameter_sanitizer.permit :account_update, keys: User::PROPERTIES
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_books
    @q = Book.ransack(params[:query])
  end

  def access_denied
    flash[:danger] = t "no_permission"
    redirect_to root_url
  end

  def not_found
    flash[:danger] = t ".not_found"
    redirect_to current_user&.is_admin ? admin_root_path : root_path
  end
end
