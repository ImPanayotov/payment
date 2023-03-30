class Customer < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :transactions, as: :transactionable
  has_many :follow_transactions, through: :transactions

  monetize :amount_cents

  validates :first_name, :last_name, { presence: true, length: { maximum: 255 } }
  validates :phone, { presence: true, length: { maximum: 15 } }
  validates :email, presence: true, email: true

  def name
    "#{first_name} #{last_name}"
  end
end
