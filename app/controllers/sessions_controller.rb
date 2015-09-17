class SessionsController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )
    login_user!(user)
    redirect_to cats_url
  end

  def destroy
    @user = current_user
    @user.reset_session_token! #forces new token to be made despite current user
    #already having a token? Because of bang?
    session[:session_token] = nil
    #automatically tries to render the 'destroy template'
    redirect_to new_session_url
  end


end
