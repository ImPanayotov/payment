class TxnHourlyRemovalWorker
  include Sidekiq::Worker

  def perform
    Transaction.where("created_at <= ?", 1.minute.ago)
               .where.not(follow_transaction_id: nil)
               .destroy_all

    Transaction.where("created_at <= ?", 1.minute.ago)
               .destroy_all
  end
end
