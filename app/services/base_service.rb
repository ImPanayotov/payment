class BaseService
  class NotImplemented < StandardError; end

  attr_accessor :success, :errors

  def initialize
    @success = false
  end

  def success?
    @success
  end

  def success!
    @success = true
  end

  def errors!
    @errors ||= ActiveModel::Errors.new(self)
  end

  def errors?
    !valid?
  end

  def valid?
    errors.blank?
  end

  def charge_service
    Api::V1::Transactions::ChargeService
  end

  def reversal_service
    Api::V1::Transactions::ReversalService
  end
end
