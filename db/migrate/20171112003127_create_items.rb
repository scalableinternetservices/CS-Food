class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.timestamps
    end

    create_table :order_items do |t|
      t.timestamps
    end

    add_index :items, :name, unique: true

    add_reference :order_items, :order, foreign_key: true, index: true
    add_reference :order_items, :item, foreign_key: true, index: true
  end
end
