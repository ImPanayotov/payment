class AddPolymorphicAssociationToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :transactionable, polymorphic: true, null: false
  end
end
