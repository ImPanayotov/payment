module Api
  module V1
    module Transactions
      class ChargeService < Api::V1::Transactions::BaseService
        attr_accessor :transaction_params,
                      :transaction,
                      :current_merchant,
                      :customer

        def initialize(transaction_params:,
                       transaction:,
                       current_merchant:,
                       customer:)
          super
          @transaction_params = transaction_params
          @transaction = transaction
          @current_merchant = current_merchant
          @customer = customer
        end

        def call
          ActiveRecord::Base.transaction do
            ChargeTransaction.create!(transaction_params) do |t|
              t.follow_transaction_id = transaction.id
              t.generate_uuid
            end

            update_customer_amount(transaction, customer, '-')
            update_merchant_total_txn_sum(transaction, current_merchant, '+')
          end
        end
      end
    end
  end
end
