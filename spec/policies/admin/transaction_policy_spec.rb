require 'rails_helper'

describe Admin::TransactionPolicy, type: :policy do
  subject do
    described_class.new(user, transaction)
  end

  let(:user) do
    create(:user, :admin)
  end

  let(:transaction) do
    create(:transaction,
           :authorized)
  end

  it_behaves_like 'admin', :index
end
