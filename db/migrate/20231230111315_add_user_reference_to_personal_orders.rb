class AddUserReferenceToPersonalOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :personal_orders, :user, null: false, foreign_key: true
  end
end
