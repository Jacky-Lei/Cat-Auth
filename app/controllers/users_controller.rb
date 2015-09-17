class UsersController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #want to log in
      #client's session token matches @user's session_token in DB
      login_user!(@user)
      # user is now logged in
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  protected
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
