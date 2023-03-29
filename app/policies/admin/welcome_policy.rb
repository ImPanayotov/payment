class Admin
  class WelcomePolicy < ApplicationPolicy
    def index?
      is_admin?
    end
  end
end
