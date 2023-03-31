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
            update_transaction_params

            form =
              Api::V1::Transactions::CreateForm.new(transaction_params)

            form.save

            transaction.reversed_status! if form.success
          end
        end

        private

        def update_transaction_params
          transaction_params[:amount_cents] = 0
          transaction_params[:type] = 'ReversalTransaction'
          transaction_params[:follow_transaction_id] = transaction.id
        end
      end
    end
  end
end
