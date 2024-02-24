class ChangeCompanyOrderReferencesInPersonalOrders < ActiveRecord::Migration[7.0]
  def change
    remove_reference :personal_orders, :company_order, null: false, foreign_key: true
    add_reference :personal_orders, :company_order, foreign_key: true
  end
end
