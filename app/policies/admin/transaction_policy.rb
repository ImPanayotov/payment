class Admin
  class TransactionPolicy < ApplicationPolicy
    def index?
      is_admin?
    end
  end
end
