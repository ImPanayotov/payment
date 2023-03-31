class TransactionFactory < BaseFactory
  attr_accessor :transaction_params,
                :transaction,
                :current_merchant,
                :type,
                :service,
                :form

  def initialize(form:,
                 transaction_params:,
                 current_merchant:)
    super
    @form = form
    @transaction_params = transaction_params
    @transaction = form.transaction
    @current_merchant = current_merchant
    @type = transaction_params[:type]
  end

  def create
    case type
    when 'AuthorizeTransaction'
      authorize_service
    when 'RefundTransaction'
      refund_service
    else
      errors.add(:base, 'Invalid transaction type')
    end

    service.call

    service.success? ? success! : handle_errors
  end

  private

  def authorize_service
    @service = Api::V1::Transactions::AuthorizeService.new(
      transaction_params:,
      transaction:,
      current_merchant:
    )
  end

  def refund_service
    @service = Api::V1::Transactions::RefundService.new(
      transaction_params:,
      transaction:,
      current_merchant:
    )
  end

  def handle_errors
    errors!
    errors.add(:base, service.errors.full_messages)
  end
end
