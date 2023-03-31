class Admin
  class CustomerPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def show?
      admin?
    end

    def update?
      admin?
    end

    def create?
      admin?
    end

    def destroy?
      admin?
    end
  end
end
