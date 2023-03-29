class Admin
  class TransactionsController < AdminController
    def index
      transactions = Transaction.order(id: :desc)

      render 'transactions/index',
             locals: { transactions: transactions }
    end
  end
end
