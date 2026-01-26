class RoomsController < ApplicationController
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_room, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  # 部屋一覧・検索
  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where(
        "name LIKE ? OR description LIKE ?",
        "%#{params[:keyword]}%",
        "%#{params[:keyword]}%"
      )
    end
  end

  # 部屋登録画面
  def new
    @room = Room.new
  end

  # 自分が登録した部屋一覧ページ
  def my_index
    @rooms = current_user.rooms.order(created_at: :desc)
  end

  # 部屋登録処理
  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設を登録しました"
    else
      render :new
    end
  end

  # 部屋詳細
  def show
    @booked_dates = @room.booked_dates
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "削除しました"
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def authorize_user!
    return if @room.user == current_user
    redirect_to rooms_path, alert: "権限がありません"
  end

  def room_params
    params.require(:room).permit(
      :name,
      :description,
      :price,
      :address,
      :image
    )
  end
end
