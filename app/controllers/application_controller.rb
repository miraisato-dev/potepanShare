# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to login_path, alert: "ログインしてください" unless logged_in?
  end
end
