class ChangeUsers < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :users do |t|
        dir.up do
          t.string :first_name, null: false, default: '', limit: 255
          t.string :last_name, null: false, default: '', limit: 255
          t.change :role, :string, default: 'user'
          t.remove :name
          t.remove :total_transaction_sum
          t.remove :amount_cents
          t.remove :amount_currency
          t.remove :description
        end

        dir.down do
          t.change :role, :string, default: 'client'

          t.string :name, null: false, default: '', length: 255
          t.text :description
          t.decimal :total_transaction_sum, precision: 8, scale: 2, default: 0
          t.monetize :amount
        end
      end
    end
  end
end
