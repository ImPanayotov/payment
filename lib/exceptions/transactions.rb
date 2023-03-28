module Transactions
  module RefundedTransactions
    class AlreadyRefundedError < StandardError
      def initialize(message = 'Already refunded')
        super
      end
    end

    class NotExistingTransactionError < StandardError
      def initialize(message = 'Transaction does not exist')
        super
      end
    end

    class NotExistingCustomerError < StandardError
      def initialize(message = 'Customer does not exist')
        super
      end
    end
  end

  module AuthorizedTransactions
    class NotExistingCustomerError < StandardError
      def initialize(message = 'Customer does not exist')
        super
      end
    end
  end
end
