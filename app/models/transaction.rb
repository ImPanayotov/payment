class Transaction < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer

  has_many :follow_transactions,
           class_name: 'Transaction',
           foreign_key: 'follow_transaction_id',
           dependent: :restrict_with_error,
           inverse_of: :follow_transactions

  enum status: { approved: 0,
                 reversed: 1,
                 refunded: 2,
                 error: 3 },
       _suffix: true

  monetize :amount_cents
end
