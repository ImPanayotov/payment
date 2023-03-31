class Admin
  class TransactionsController < AdminController
    def index
      transactions = Transaction.order(id: :desc)

      authorize(transactions)

      render 'transactions/index',
             locals: { transactions: }
    end
  end
end
