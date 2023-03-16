class WelcomeController < ApplicationController
  def index
    transactions_count = Transaction.count
    merchants_count = Merchant.count

    render 'welcome/index',
           locals: { transactions_count: transactions_count,
                     merchants_count: merchants_count }
  end
end
