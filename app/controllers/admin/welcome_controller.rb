class Admin
  class WelcomeController < BaseController
    def index
      authorize(:welcome)

      transactions_count = Transaction.count
      merchants_count = Merchant.count
      customers_count = Customer.count

      render 'welcome/index',
             locals: { transactions_count:,
                       merchants_count:,
                       customers_count: }
    end
  end
end
