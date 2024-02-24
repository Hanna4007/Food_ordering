class CreateCompanyOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :company_orders do |t|
      t.decimal :company_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
