class Admin
  class TransactionsController < BaseController
    def index
      transactions = Transaction.order(id: :desc)

      authorize(transactions)

      render 'transactions/index',
             locals: { transactions: }
    end
  end
end
