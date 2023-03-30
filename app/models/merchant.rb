class Merchant < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         :rememberable,
         jwt_revocation_strategy: self

  has_many :transactions, dependent: :restrict_with_error
  has_many :follow_transactions, through: :transactions

  enum status: { active: 0, inactive: 1 }

  monetize :total_transaction_sum_cents

  validates :name, { presence: true, length: { maximum: 255 } }
  validates :email, presence: true, email: true

end
