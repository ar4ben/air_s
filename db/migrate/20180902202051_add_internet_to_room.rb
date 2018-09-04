class AddInternetToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :is_internet, :boolean
  end
end
