class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false 
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
