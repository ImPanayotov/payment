class Merchant < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include DeviseConcern

  has_many :transactions, dependent: :restrict_with_exception
  has_many :follow_transactions, through: :transactions

  enum status: { active: 0, inactive: 1 }

  monetize :total_transaction_sum_cents

  validates :name, { presence: true, length: { maximum: 255 } }
  validates :email, presence: true, email: true
end
