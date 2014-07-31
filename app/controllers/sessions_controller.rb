class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login!(user)
      redirect_to dragons_url
    else
      render :new
    end
  end

  def destroy
    current_session = Session.find_by_token(session[:token])
    session[:token] = nil
    current_session.destroy
    redirect_to new_session_url
  end
end