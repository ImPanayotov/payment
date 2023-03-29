class Admin
  class MerchantPolicy < ApplicationPolicy
    def index?
      is_admin?
    end

    def show?
      is_admin?
    end

    def update?
      is_admin?
    end

    def create?
      is_admin?
    end

    def destroy?
      is_admin?
    end
  end
end
