class AddFiledsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
