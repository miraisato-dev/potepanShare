class AddAreaToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :area, :string
  end
end
