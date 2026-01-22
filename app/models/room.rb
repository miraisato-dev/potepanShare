# app/models/room.rb
class Room < ApplicationRecord
  has_many :reservations, dependent: :destroy
  belongs_to :user
  has_one_attached :image

  # 予約済みの日付配列を返す
  def booked_dates
    reservations.flat_map do |r|
      # チェックアウト日は予約可能にしたいので exclude
      (r.start_date...r.end_date).to_a
    end
  end
end
