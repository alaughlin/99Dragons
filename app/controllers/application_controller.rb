class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  private
  def login!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def current_user
    return unless session[:token]
    @current_user ||= User.where(session_token: session[:token]).first

    @current_user
  end

  def signed_in?
    !!current_user
  end

  def already_logged_in
    if signed_in?
      redirect_to dragons_url
    end
  end

  def not_logged_in
    redirect_to new_session_url unless signed_in?
  end
end
