class SessionsController < ApplicationController

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
    user = User.find_by(session_token: session[:token])
    session[:token] = nil
    user.reset_session_token!
    redirect_to new_session_url
  end

end