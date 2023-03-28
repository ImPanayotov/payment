require 'exceptions/transactions'

module Api
  module V1
    module Transactions
      class AuthorizeService < Api::V1::Transactions::BaseService
        attr_accessor :transaction_params,
                      :transaction,
                      :current_merchant

        def initialize(transaction_params:,
                       transaction:,
                       current_merchant:)
          super
          @transaction_params = transaction_params
          @transaction = transaction
          @current_merchant = current_merchant
        end

        def call
          customer = find_customer(transaction_params)
          validate_customer!(customer)

          if valid_amount?(customer, transaction)
            charge_service.new(transaction_params:,
                               transaction:,
                               current_merchant:,
                               customer:).call
          else
            reversal_service.new(transaction_params:,
                                 transaction:).call
          end

          success!
        rescue ::Transactions::AuthorizedTransactions::NotExistingCustomerError,
               StandardError => error
          transaction.error_status!
          errors.add(:base, error.message)
        end

        private

        def transaction_type
          'AuthorizedTransactions'
        end
      end
    end
  end
end
