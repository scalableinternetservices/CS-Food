class CreateUserMenus < ActiveRecord::Migration[5.1]
  def change
    create_table :user_menus do |t|

      t.timestamps
    end


    add_reference :user_menus, :user, foreign_key: true, index: true
    add_reference :user_menus, :item, foreign_key: true, index: true

  end
end
