require 'exceptions/transactions'

module Api
  module V1
    module Transactions
      class BaseService < ::BaseService
        def initialize(*attrs); end

        def call
          raise NotImplementedError
        end

        def update_customer_amount(transaction, customer, operator)

          amount = customer
                     .amount
                     .public_send(operator, transaction.amount)

          customer.update(amount:)
        end

        def update_merchant_total_txn_sum(transaction, current_merchant, operator)

          total_transaction_sum = current_merchant
                                    .total_transaction_sum
                                    .public_send(operator, transaction.amount)

          current_merchant.update(total_transaction_sum:)
        end

        def find_customer(transaction_params)
          Customer.find_by(id: transaction_params[:customer_id])
        end

        def validate_customer!(customer)
          raise "::Transactions::#{transaction_type}::NotExistingCustomerError".constantize unless customer
        end

        

        def valid_amount?(customer, transaction)
          customer.amount >= transaction.amount
        end

        def transaction_type
          raise NotImplemented
        end
      end
    end
  end
end
