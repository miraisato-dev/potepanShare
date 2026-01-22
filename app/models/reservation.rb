class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, presence: true
  validate :start_before_end
  validate :no_date_overlap, if: -> { start_date.present? && end_date.present? }

  before_validation :calculate_total_price

  private

  def calculate_total_price
    return if start_date.blank? || end_date.blank? || room.blank?

    nights = (end_date - start_date).to_i
    self.total_price = nights * room.price
  end

  def start_before_end
    return if start_date.blank? || end_date.blank?

    if start_date >= end_date
      errors.add(:end_date, "は開始日より後にしてください")
    end
  end

  def no_date_overlap
    return if start_date.blank? || end_date.blank?

    scope = Reservation.where(room_id: room_id)

    # 自分自身を除外（更新時のみ）
    scope = scope.where.not(id: id) if persisted?

    if scope.where("start_date < ? AND end_date > ?", end_date, start_date).exists?
      errors.add(:base, "その期間はすでに予約されています")
    end
  end
end
