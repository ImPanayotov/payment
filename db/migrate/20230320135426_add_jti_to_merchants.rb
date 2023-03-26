class AddJtiToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :jti, :string
    add_index :merchants, :jti
  end
end
