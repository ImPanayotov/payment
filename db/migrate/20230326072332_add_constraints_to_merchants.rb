class AddConstraintsToMerchants < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :merchants do |t|
        dir.up do
          t.change :name, :string, limit: 255
        end

        dir.down do
          t.remove :name
        end
      end
    end
  end
end
