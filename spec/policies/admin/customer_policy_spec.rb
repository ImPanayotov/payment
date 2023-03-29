require 'rails_helper'

describe Admin::CustomerPolicy, type: :policy do
  subject do
    described_class.new(user, customer)
  end

  let(:user) do
    create(:user, :admin)
  end

  let(:customer) do
    create(:customer)
  end

  it_behaves_like 'admin', :index
  it_behaves_like 'admin', :show
  it_behaves_like 'admin', :update
  it_behaves_like 'admin', :create
  it_behaves_like 'admin', :destroy
end
