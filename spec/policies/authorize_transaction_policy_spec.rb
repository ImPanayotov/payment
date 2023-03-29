require 'rails_helper'

describe AuthorizeTransactionPolicy, type: :policy do
  subject do
    described_class.new(merchant, transaction)
  end

  let(:merchant) do
    create(:merchant)
  end

  let(:transaction) do
    create(:transaction,
           :authorized,
           merchant: merchant)
  end

  describe '.authorize_transaction?' do
    it { is_expected.to permit_action(:authorize_transaction) }
  end
end
