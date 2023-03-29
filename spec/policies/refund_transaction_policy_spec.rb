require 'rails_helper'

describe RefundTransactionPolicy, type: :policy do
  subject do
    described_class.new(merchant, transaction)
  end

  let(:merchant) do
    create(:merchant)
  end

  let(:transaction) do
    create(:transaction,
           :refunded,
           merchant: merchant)
  end

  describe '.refund_transaction?' do
    it { is_expected.to permit_action(:refund_transaction) }
  end
end
