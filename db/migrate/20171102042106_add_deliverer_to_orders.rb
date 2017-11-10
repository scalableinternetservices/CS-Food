class AddDelivererToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :deliverer_id, :integer
    add_column :orders, :delivered_at, :datetime
  end
end
