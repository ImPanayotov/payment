require 'rails_helper'

RSpec.describe Api::V1::Transactions::AuthorizeService, type: :service do
  subject(:service) do
    described_class.new(transaction_params:,
                        transaction:,
                        current_merchant: merchant)
  end

  let(:customer) do
    create(:customer)
  end

  let(:merchant) do
    create(:merchant)
  end

  let(:transaction) do
    create(:transaction,
           :authorized)
  end

  let(:transaction_params) do
    { merchant_id: merchant.id,
      amount_cents: 100_000,
      customer_id: customer.id,
      details: 'No details' }
  end

  it 'is successful' do
    expect do
      service.call
      customer.reload
    end.to change(AuthorizeTransaction, :count).by(1)
       .and change(ChargeTransaction, :count).by(1)
       .and change(customer, :amount_cents).from(10_000_00).to(9_990_00)
       .and change(merchant, :total_transaction_sum_cents).from(0).to(10_00)

    expect(service).to be_success
  end

  context 'with errors' do
    context 'when invalid params' do
      let(:customer) do
        create(:customer,
               amount_cents: 9_00)
      end

      context 'when customer has insufficient amount' do
        it do
          expect do
            service.call
          end.to change(AuthorizeTransaction, :count).by(1)
             .and change(ReversalTransaction, :count).by(1)

          expect(AuthorizeTransaction.last.status).to eq('reversed')
          expect(ReversalTransaction.last.status).to eq('approved')

          expect(service).to be_success
        end
      end

      context 'when not existing customer' do
        let(:transaction_params) do
          { merchant_id: merchant.id,
            amount_cents: 100_000,
            customer_id: 'invalid',
            details: 'No details' }
        end

        it do
          expect do
            service.call
          end.to change(AuthorizeTransaction, :count).by(1)

          expect(ReversalTransaction.count).to be_zero
          expect(AuthorizeTransaction.last.status).to eq('error')

          expect(service).not_to be_success
          expect(service.errors[:base]).to include('Customer does not exist')
        end
      end
    end
  end
end
