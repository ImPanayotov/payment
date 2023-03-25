class RefundTransactionPolicy < ApplicationPolicy
  def refund_transaction?
    user.id == record.merchant_id
  end
end
