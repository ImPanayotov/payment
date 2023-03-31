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
           merchant:)
  end

  describe '.authorize_transaction?' do
    context 'with active merchant' do
      it { is_expected.to permit_action(:authorize_transaction) }
    end

    context 'with inactive merchant' do
      let(:merchant) do
        create(:merchant,
               status: 'inactive')
      end

      it { is_expected.to forbid_action(:authorize_transaction) }
    end
  end
end
