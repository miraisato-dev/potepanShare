# app/models/room.rb
class Room < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :reservations, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0, message: "は0以上で入力してください" }
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true

  # 予約済みの日付配列を返す
  def booked_dates
    reservations.flat_map do |r|
      # チェックアウト日は予約可能にしたいので exclude
      (r.start_date...r.end_date).to_a
    end
  end
end
