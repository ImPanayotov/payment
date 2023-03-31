module DeviseConcern
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable,
           :registerable,
           :recoverable,
           :validatable,
           :jwt_authenticatable,
           :rememberable,
           jwt_revocation_strategy: self
  end
end
