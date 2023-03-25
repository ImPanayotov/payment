class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :uuid, null: false
      t.monetize :amount
      t.references :merchant
      t.references :follow_transaction, foreign_key: { to_table: :transactions }
      t.integer :status, null: false, default: 0
      t.string :type, null: false, default: ''
      t.text :details

      t.timestamps
    end
  end
end
