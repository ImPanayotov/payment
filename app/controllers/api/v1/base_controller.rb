module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_merchant!

      def policy_scope(scope)
        super([:api, :v1, scope])
      end

      def authorize(record, query = nil)
        super([:api, :v1, record], query)
      end

      def pundit_user
        current_merchant
      end
    end
  end
end
