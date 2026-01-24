# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update, :edit_account, :update_account, :edit_profile, :update_profile]   # edit/update用に@userをセット
  before_action :require_login, only: [ :edit, :update, :edit_account, :update_account, :edit_profile, :update_profile] # ログイン必須

  # 新規登録画面
  def new
    @user = User.new
  end

  # 新規登録処理
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "登録が完了しました。ログインしてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集画面
  def edit
    # @user は set_user で current_user が入る
  end

  # 更新処理
  def update
    if @user.update(user_params)
      redirect_to edit_account_path, notice: "アカウント情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 新規追加：アカウント情報編集
  def edit_account
    # @user は set_user で current_user が入る
  end

  # 新規追加：アカウント情報編集
  def update_account
    if @user.update(account_params)
      redirect_to edit_account_path, notice: "アカウント情報を更新しました"
    else
      render :edit_account, status: :unprocessable_entity
    end
  end

  # 新規追加：プロフィール編集
  def edit_profile
  end

  def update_profile
    if @user.update(profile_params)
      redirect_to edit_profile_path, notice: "プロフィールを更新しました"
    else
      render :edit_profile, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  # Strong Parameters
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :bio,    # 自己紹介
      :avatar  # プロフィール画像
    )
  end

  def my_page
    @user = current_user
    @reservations = @user.reservations.includes(:room).order(start_date: :desc)
  end

  # update用アクションは既存のupdateを使用する
end
