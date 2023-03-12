class AddColumnsToMerchants < ActiveRecord::Migration[7.0]
  def change
    change_table :merchants, bulk: true do |t|
      t.string :name, null: false, default: ''
      t.text :description
      t.integer :status, null: false, default: 0
      t.decimal :total_transaction_sum, precision: 8, scale: 2, default: 0
    end
  end
end
