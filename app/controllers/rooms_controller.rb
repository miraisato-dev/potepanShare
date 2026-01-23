# app/controllers/rooms_controller.rb
class RoomsController < ApplicationController
  before_action :require_login, only: [ :new, :create ]

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

  # # 部屋検索
  # def search
  #   @rooms = Room.all

  #   # エリア検索（住所のあいまい検索）
  #   if params[:area].present?
  #     @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
  #   end

  #   # フリーワード検索（施設名・詳細）
  #   if params[:keyword].present?
  #     @rooms = @rooms.where(
  #       "name LIKE ? OR description LIKE ?",
  #       "%#{params[:keyword]}%",
  #       "%#{params[:keyword]}%"
  #     )
  #   end
  # end

  # 部屋登録画面
  def new
    @room = Room.new
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
    @room = Room.find(params[:id])
    @booked_dates = @room.booked_dates
  end

  private

  # 部屋パラメータ
  def room_params
    params.require(:room).permit(:name, :description, :price, :address)
  end
end
