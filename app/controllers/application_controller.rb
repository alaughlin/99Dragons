class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def login(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end
end
