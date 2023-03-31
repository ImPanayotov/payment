module Api
  module V1
    module Transactions
      class CreateForm
        include ActiveModel::Model

        attr_accessor :uuid,
                      :amount_cents,
                      :amount_currency,
                      :merchant_id,
                      :follow_transaction_id,
                      :status,
                      :type,
                      :details,
                      :customer_id,
                      :success,
                      :transaction

        TYPES = %w[AuthorizeTransaction
                   ChargeTransaction
                   ReversalTransaction
                   RefundTransaction].freeze

        validates :uuid, :status, :type, presence: true
        validates :type, inclusion: { in: TYPES }

        def generate_uuid
          @uuid = SecureRandom.uuid
        end

        def initialize(attributes = {})
          super
          @uuid = generate_uuid
          @status = 'approved'
          @amount_currency = 'USD'
        end

        def save
          ActiveRecord::Base.transaction do
            if valid?
              @transaction =
                Transaction.create(uuid:,
                                   amount_cents:,
                                   amount_currency:,
                                   merchant_id:,
                                   follow_transaction_id:,
                                   status:,
                                   type:,
                                   details:,
                                   customer_id:)

              @success = true
            else
              @success = false
            end
          rescue StandardError => e
            errors.add(:base, e.message)
            @success = false
          end
        end
      end
    end
  end
end
