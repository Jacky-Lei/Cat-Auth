class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login_user!(user)
    user.reset_session_token! #saves in database
    session[:session_token] = user.session_token
  end
end
