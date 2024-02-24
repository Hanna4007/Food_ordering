class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.string :name
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.integer :quantity
      t.references :personal_order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
