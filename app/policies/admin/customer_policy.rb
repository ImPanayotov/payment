class Admin
  class CustomerPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      true
    end

    def update?
      true
    end

    def create?
      true
    end

    def destroy?
      true
    end
  end
end
