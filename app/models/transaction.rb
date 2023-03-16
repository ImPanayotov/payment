class Transaction < ApplicationRecord
  belongs_to :merchant

  enum :status, { approved: 0,
                  reversed: 1,
                  refunded: 2,
                  error: 3 },
       _suffix: true

  monetize :amount_cents
end
