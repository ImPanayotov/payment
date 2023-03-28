module Api
  module V1
    module Transactions
      class ReversalService < Api::V1::Transactions::BaseService
        attr_accessor :transaction_params,
                      :transaction

        def initialize(transaction_params:, transaction:)
          super
          @transaction_params = transaction_params
          @transaction = transaction
        end

        def call
          ActiveRecord::Base.transaction do
            ReversalTransaction.create!(transaction_params) do |t|
            t.follow_transaction_id = transaction.id
              t.generate_uuid
              t.amount_cents = 0
            end

            transaction.reversed_status!
          end
        end
      end
    end
  end
end
