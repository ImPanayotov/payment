class TxnHourlyRemovalWorker
  include Sidekiq::Worker

  def perform
    Transaction.where.not(follow_transaction_id: nil).destroy_all
    Transaction.destroy_all
  end
end
