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
            update_transaction_params

            form =
              Api::V1::Transactions::CreateForm.new(transaction_params)

            form.save

            update_customer_amount(transaction, customer, '-')
            update_merchant_total_txn_sum(transaction, current_merchant, '+')
          end
        end

        private

        def update_transaction_params
          transaction_params[:type] = 'ChargeTransaction'
          transaction_params[:follow_transaction_id] = transaction.id
        end
      end
    end
  end
end
