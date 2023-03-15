class TransactionsController < ApplicationController
  def index
    transactions = Transaction.all

    render 'transactions/index',
           locals: { transactions: transactions }
  end
end
