class CreatePersonalOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :personal_orders do |t|
      t.decimal :total_price, precision: 10, scale: 2
      t.references :company_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
