# app/controllers/reservations_controller.rb
class ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_room, only: [ :new, :confirm, :create, :show, :destroy ]
  # indexにはset_roomをかけてばいけない

  # 予約入力画面
  def new
    @reservation = Reservation.new
  end

  # 予約確認画面
  def confirm
    if request.post?
      @reservation = current_user.reservations.build(
        reservation_params.merge(room: @room)
      )

      unless @reservation.valid?
        flash.now[:alert] = @reservation.errors.full_messages.join(", ")
        render "rooms/show", status: :unprocessable_entity
        return
      end

      session[:reservation] = reservation_params
    end

    # POSTで来たときもGETで来たときもここを通るようにする 両対応
    if session[:reservation].blank?
      redirect_to room_path(@room), alert: "予約情報がありません"
      return
    end

    # GET のとき
    @reservation = Reservation.new(session[:reservation])
    @reservation.room = @room
    @reservation.user = current_user
    @reservation.valid?  # ← これを入れないと合計金額が出ないエラーになる
  end

  # 予約作成　確定版
  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      session.delete(:reservation) # 二重送信防止
      redirect_to my_reservations_path, notice: "予約が完了しました" # turbo対応につきredirect_toは必須
    else
      flash.now[:alert] = @reservation.errors.full_messages.join(", ")
      render :confirm, status: :unprocessable_entity
    end
  end

  # 予約一覧
  def index
    @room = Room.find(params[:room_id]) # set_roomは使わない
    @reservations = current_user.reservations # 他人の予約を見せないようにする
                                .includes(:room)  # N＋1問題対策
                                .order(start_date: :desc) # 日付降順で新しい予約が上
  end

  # ユーザー全体の予約一覧
  def my_index
    @reservations = current_user.reservations.includes(:room).order(created_at: :desc)
  end

  # 予約詳細
  def show
    @reservation = @room.reservations.find(params[:id])
  end

  # キャンセル
  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to my_reservations_path, notice: "予約をキャンセルしました"
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def reservation_params
    return {} if params[:reservation].blank?

    raw = params.require(:reservation).permit(:start_date, :end_date, :guest_count)
    {
      start_date: raw[:start_date].present? ? Date.parse(raw[:start_date]) : nil,
      end_date:   raw[:end_date].present?   ? Date.parse(raw[:end_date])   : nil,
      guest_count: raw[:guest_count]
    }
  end
end
