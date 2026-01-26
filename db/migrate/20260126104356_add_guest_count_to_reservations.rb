class AddGuestCountToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :guest_count, :integer
  end
end
