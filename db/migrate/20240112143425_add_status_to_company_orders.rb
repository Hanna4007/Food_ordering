class AddStatusToCompanyOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :company_orders, :status, :string, default: "in progress", null: false
  end
end
