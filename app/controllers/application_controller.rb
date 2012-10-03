class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  private

  def logged_in?
    !!session[:current_user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to logins_url
    end
  end

  def current_user
    @current_user = if session[:current_user_id]
      User.find(session[:current_user_id])
    end
  end
end
