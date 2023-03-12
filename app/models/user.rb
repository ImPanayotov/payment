class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %i[admin].freeze

  validates :role, presence: true, inclusion: {
    in: ROLES.map(&:to_s),
    allow_nil: true
  }

  ROLES.each do |role|
    define_method "#{role}_role?" do
      role?(role)
    end
  end

  def role?(name)
    role == name.to_s
  end
end
