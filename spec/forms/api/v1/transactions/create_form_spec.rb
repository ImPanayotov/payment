require 'rails_helper'

RSpec.describe Api::V1::Transactions::CreateForm, type: :model do
  subject(:form) { described_class.new(params) }

  let(:customer) do
    create(:customer)
  end

  let(:params) do
    {
      amount_cents: 10_00,
      customer_id: customer.id,
      details: 'N/A',
      type: 'AuthorizationTransaction'
    }
  end

  describe 'validations' do
    %i[uuid
       status
       type].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end

    it do
      expect(subject).to validate_inclusion_of(:type).in_array(described_class::TYPES)
    end
  end
end
