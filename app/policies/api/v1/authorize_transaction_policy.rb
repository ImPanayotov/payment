module Api
  module V1
    class AuthorizeTransactionPolicy < ApplicationPolicy
      def authorize_transaction?
        correct_user? && user.active?
      end
    end
  end
end
