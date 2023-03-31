class TransactionsController < ApplicationController
  def index
    transactions = Transaction.order(id: :desc)

    render 'transactions/index',
           locals: { transactions: }
  end
end
