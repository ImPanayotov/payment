class AuthorizeTransactionPolicy < ApplicationPolicy
  def authorize_transaction?
    user.id == record.merchant_id
  end
end
