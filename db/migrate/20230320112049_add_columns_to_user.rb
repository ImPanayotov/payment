class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :name, null: false, default: '', length: 255
      t.text :description
      t.integer :status, null: false, default: 0
      t.decimal :total_transaction_sum, precision: 8, scale: 2, default: 0
      t.monetize :amount
    end
  end
end
