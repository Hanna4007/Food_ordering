class AddStatusToPersonalOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :personal_orders, :status, :string, default: "in progress", null: false
  end
end
