class Merchant < ApplicationRecord
  has_many :transactions

  enum :status, { active: 0, inactive: 1 }
end
