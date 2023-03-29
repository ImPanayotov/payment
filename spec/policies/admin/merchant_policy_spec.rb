require 'rails_helper'

describe Admin::MerchantPolicy, type: :policy do
  subject do
    described_class.new(user, merchant)
  end

  let(:user) do
    create(:user, :admin)
  end

  let(:merchant) do
    create(:merchant)
  end

  it_behaves_like 'admin', :index
  it_behaves_like 'admin', :show
  it_behaves_like 'admin', :update
  it_behaves_like 'admin', :create
  it_behaves_like 'admin', :destroy
end
