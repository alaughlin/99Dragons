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
    p current_user
    !!current_user
  end
end
