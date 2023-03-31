module Api
  module V1
    class TransactionsController < BaseController
      InvalidAuthorizeTransaction = Class.new(StandardError)
      InvalidRefundTransaction = Class.new(StandardError)

      def authorize_transaction
        form =
          Api::V1::Transactions::CreateForm.new(transaction_params)

        form.save

        raise InvalidAuthorizeTransaction unless form.success

        authorize(form.transaction)

        factory = TransactionFactory.new(
          form:,
          transaction_params:,
          current_merchant:
        )

        factory.create

        if factory.success
          render json: factory.service.transaction,
                 status: :created
        else
          render json: factory.errors,
                 status: :unprocessable_entity
        end
      rescue InvalidAuthorizeTransaction,
             StandardError => e
        @errors = e.message
        render json: e.message,
               status: :unprocessable_entity
      end

      def refund_transaction
        form =
          Api::V1::Transactions::CreateForm.new(transaction_params)

        form.save

        raise InvalidRefundTransaction unless form.success

        authorize(form.transaction)

        factory = TransactionFactory.new(
          form:,
          transaction_params:,
          current_merchant:
        )

        factory.create

        if factory.success?
          render json: factory.service.transaction,
                 status: :created
        else
          render json: factory.errors,
                 status: :unprocessable_entity
        end
      rescue InvalidAuthorizeTransaction,
             StandardError => e
        @errors = e.message
        render json: e.message,
               status: :unprocessable_entity
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
           details
           type]
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
