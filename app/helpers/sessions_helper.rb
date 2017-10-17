module SessionsHelper

  # login the user
  def log_in(user)
    session[:user_id] = user.id
  end

  # save the login_state
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # return true if the logged user equal the user
  def current_user?(user)
    user == current_user
  end

  # return the current_user (if it's avliable)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true if the user was logged_in, or teturn false
  def logged_in?
    !current_user.nil?
  end

  # forget cookie
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # log out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # redirect to the saved url
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # save the url waitting to redirect
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
