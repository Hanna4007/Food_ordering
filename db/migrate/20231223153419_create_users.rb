class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :phone_number, null: false
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
