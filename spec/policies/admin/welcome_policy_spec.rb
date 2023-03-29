require 'rails_helper'

describe Admin::WelcomePolicy, type: :policy do
  subject do
    described_class.new(user, nil)
  end

  let(:user) do
    create(:user, :admin)
  end

  it_behaves_like 'admin', :index
end
