class Admin
  class WelcomePolicy < ApplicationPolicy
    def index?
      admin?
    end
  end
end
