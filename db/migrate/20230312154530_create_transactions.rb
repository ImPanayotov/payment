class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :uuid, null: false
      t.monetize :amount
      t.references :merchant
      t.integer :status, null: false, default: 0
      t.string :customer_email, null: false, default: ''
      t.string :customer_phone, null: false, default: ''
      t.text :details

      t.timestamps
    end
  end
end
