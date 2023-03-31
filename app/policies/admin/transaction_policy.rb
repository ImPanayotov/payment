class Admin
  class TransactionPolicy < ApplicationPolicy
    def index?
      admin?
    end
  end
end
