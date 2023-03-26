class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %i[admin client merchant]

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         :recoverable,
         :rememberable,
         jwt_revocation_strategy: self

  has_many :transactions, dependent: :restrict_with_exception

  enum :status, { active: 0, inactive: 1 }

  monetize :amount_cents

  scope :with_role, ->(role) { where(role:) }

  scope :admins, -> { with_role(:admin) }
  scope :clients, -> { with_role(:client) }
  scope :merchants, -> { with_role(:merchant) }


  ROLES.each do |role|
    define_method "#{role}_role?" do
      role?(role)
    end
  end

  def role?(name)
    role == name.to_s
  end
end
