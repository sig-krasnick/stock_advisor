class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :identifier
      t.string :description
      t.decimal :last_price
      t.decimal :current_price

      t.timestamps
    end
  end
end
