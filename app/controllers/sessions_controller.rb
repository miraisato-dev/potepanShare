# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = "メールかパスワードが違います"
      render :new
    end
  end

  # --- ここからゲストログイン用の追加メソッド ---
  def guest_login
    # ゲストユーザーがいれば取得、いなければ新しく作成
    user = User.find_or_create_by!(email: "guest@example.com") do |u|
      u.name = "ゲストユーザー"
      u.password = SecureRandom.urlsafe_base64
      u.password_confirmation = u.password
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "ログアウトしました"
  end
end
