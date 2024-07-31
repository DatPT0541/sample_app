class ApplicationController < ActionController::Base
  before_action :set_locale

  def create; end

  def destroy; end

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".message.please_log_in"
    redirect_to login_url
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protect_from_forgery with: :exception
  include SessionsHelper
  include Pagy::Backend
end
