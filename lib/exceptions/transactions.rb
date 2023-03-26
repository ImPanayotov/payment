module Transactions
  module RefundedTransactions
    class AlreadyRefundedError < StandardError
      def initialize(message = 'Already refunded')
        super
      end
    end
  end
end
