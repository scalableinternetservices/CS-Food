class AddPointsToOrdersAndUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :points, :integer, default: 1000
    add_column :orders, :points, :integer
  end
end