class TxnHourlyRemovalWorker
  include Sidekiq::Worker

  def perform
    Transaction.where('created_at <= ?', 1.hour.ago)
               .where.not(follow_transaction_id: nil)
               .destroy_all

    Transaction.where('created_at <= ?', 1.hour.ago)
               .destroy_all
  end
end
