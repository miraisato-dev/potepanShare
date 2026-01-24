# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_many :rooms, dependent: :destroy   # これを追加
  has_one_attached :avatar # ActiveStorageでアイコン画像を管理

  # 予約との関連
  has_many :reservations, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end