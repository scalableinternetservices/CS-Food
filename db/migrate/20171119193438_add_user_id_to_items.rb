class AddUserIdToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :users, foreign_key: true, index: true
  end
end
