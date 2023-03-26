class AddConstraintsToCustomers < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :customers do |t|
        dir.up do
          t.change :first_name, :string, default: '', null: false, limit: 255
          t.change :last_name, :string, default: '', null: false, limit: 255
          t.change :phone, :string, default: '', null: false, limit: 15
          t.remove :total_transaction_sum
        end

        dir.down do
          t.remove :first_name, default: nil, null: true
          t.remove :last_name, default: nil, null: true
          t.remove :phone, default: nil, null: true
        end
      end
    end
  end
end
