require 'exceptions/transactions'

module Api
  module V1
    module Transactions
      class RefundService < Api::V1::Transactions::BaseService
        attr_accessor :transaction_params,
                      :transaction,
                      :current_merchant,
                      :amount_cents,
                      :customer,
                      :uuid

        def initialize(transaction_params:,
                       transaction:,
                       current_merchant:)
          super
          @transaction_params = transaction_params
          @transaction        = transaction
          @current_merchant   = current_merchant
          @amount_cents       = transaction_params[:amount_cents]
          @customer           = find_customer(transaction_params)
          @uuid               = transaction_params[:uuid]
        end

        def call
          charge_transaction = find_charge_txn
          charge_transaction_refunded?(charge_transaction)

          ActiveRecord::Base.transaction do
            transaction.update!(
              follow_transaction_id: charge_transaction.id,
            )

            update_customer_amount(charge_transaction, customer, '+')
            update_merchant_total_txn_sum(charge_transaction, current_merchant, '-')

            charge_transaction.refunded!
          end

          success!
        rescue ::Transactions::RefundedTransactions::AlreadyRefundedError,
               StandardError => e
          transaction.error!
          errors.add(:base, e.message)
        end

        private

        def find_charge_txn
          ChargeTransaction.find_by!(amount_cents:,
                                     customer_id: customer.id,
                                     merchant_id: current_merchant.id,
                                     uuid:)
        end

        def charge_transaction_refunded?(transaction)
          raise ::Transactions::RefundedTransactions::AlreadyRefundedError if transaction.refunded?
        end
      end
    end
  end
end
