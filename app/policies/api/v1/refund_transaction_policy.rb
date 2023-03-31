module Api
  module V1
    class RefundTransactionPolicy < ApplicationPolicy
      def refund_transaction?
        correct_user? && user.active?
      end
    end
  end
end
