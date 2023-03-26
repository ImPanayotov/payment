class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :transactions, dependent: :restrict_with_exception
  has_many :follow_transactions, through: :transactions

  monetize :amount_cents

  def name
    "#{first_name} #{last_name}"
  end
end
