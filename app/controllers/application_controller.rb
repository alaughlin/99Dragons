class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  private
  def login!(user)
    @session = Session.new(user_id: user.id)
    @session.save!

    session[:token] = @session.token
  end

  def current_user
    return unless session[:token]
    user_id = ([<<-SQL, session[:token]])
    select
    users.*
    from
    sessions
    join
    users on sessions.user_id = users.id
    where
    sessions.token = ?
    SQL

    @current_user ||= User.find_by_sql(user_id).first

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
