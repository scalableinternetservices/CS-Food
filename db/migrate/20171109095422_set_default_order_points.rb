class SetDefaultOrderPoints < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :points, :integer, default: 0
  end
end
