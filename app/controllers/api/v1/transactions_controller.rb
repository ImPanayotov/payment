module Api
  module V1
    class TransactionsController < ApplicationController
      # include MerchantsBasicAuthConcern

      def authorize_transaction
        transaction = AuthorizeTransaction.create!(transaction_params)

        authorize(transaction)

        service = Api::V1::Transactions::AuthorizeService.new(
          transaction_params: transaction_params,
          transaction: transaction,
          current_merchant: current_merchant
        )

        service.call

        if service.success?
          render json: service.transaction,
                 status: :created
        else
          render json: service.errors,
                 status: :unprocessable_entity
        end
      end

      def refund_transaction
        transaction = RefundTransaction.create!(transaction_params)

        authorize(transaction)

        service = Api::V1::Transactions::RefundService.new(
          transaction_params: transaction_params,
          transaction: transaction,
          current_merchant: current_merchant
        )

        service.call
        if service.success?
          render json: service.transaction,
                 status: :created
        else
          render json: service.errors,
                 status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction)
              .permit(transaction_attrs)
              .merge!(merge_params)
      end

      def transaction_attrs
        %i[id
           amount_cents
           customer_id
           details]
      end

      def merge_params
        { uuid: params[:id],
          merchant_id: current_merchant.id }
      end

      def pundit_user
        current_merchant
      end
    end
  end
end
