class SessionsController < ApplicationController
  before_action :find_user_by_email, only: :create

  def new; end

  def create
    if user_authenticated? @user
      handle_authenticated_user @user
    else
      handle_failed_authentication
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  private

  def find_user_by_email
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)
    handle_user_not_found if @user.nil?
  end

  def handle_user_not_found
    flash.now[:danger] = t ".message.invalid_email_password_combination"
    render :new, status: :unprocessable_entity
  end

  def user_authenticated? user
    user.authenticate(params.dig(:session, :password))
  end

  def handle_authenticated_user user
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in user
    params.dig(:session, :remember_me) == "1" ? remember(user) : forget(user)
    redirect_to forwarding_url || user
  end

  def handle_failed_authentication
    flash.now[:danger] = t ".message.invalid_email_password_combination"
    render :new, status: :unprocessable_entity
  end
end
