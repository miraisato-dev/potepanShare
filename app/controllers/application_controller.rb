class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
