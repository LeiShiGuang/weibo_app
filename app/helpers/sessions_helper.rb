module SessionsHelper

  # login the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # return the current_user (if it's avliable)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true if the user was logged_in, or teturn false
  def logged_in?
    !current_user.nil?
  end

  # log out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
