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
    context 'with inactive merchant' do
      it { is_expected.to permit_action(:refund_transaction) }
    end

    context 'with inactive merchant' do
      let(:merchant) do
        create(:merchant,
               status: 'inactive')
      end

      it { is_expected.to forbid_action(:refund_transaction) }
    end
  end
end
