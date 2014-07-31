class UsersController < ApplicationController
  before_action :logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:token] = @user.session_token
      redirect_to dragons_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end