class User < ApplicationRecord
  # include Devise::JWT::RevocationStrategies::JTIMatcher

  ROLES = %w[admin user].freeze

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         :recoverable,
         :rememberable,
         jwt_revocation_strategy: self

  enum status: { active: 0, inactive: 1 }

  validates :first_name,
            :last_name,
            length: { maximum: 255 }

  validates :email,
            :role,
            :first_name,
            :last_name,
            :status,
            presence: true

  validates :email,
            email: true

  validates :role,
            inclusion: { in: ROLES }

  scope :with_role, ->(role) { where(role:) }

  scope :admins, -> { with_role(:admin) }
  scope :users, -> { with_role(:user) }
  scope :active, -> { where(status: 'active') }

  def self.active_admins_created_after(date)
    admins.active.where('users.created_at > ?', date)
  end

  ROLES.each do |role|
    define_method "#{role}_role?" do
      role?(role)
    end
  end

  def role?(name)
    role == name.to_s
  end
end
