require 'rails_helper'

RSpec.describe Api::V1::Transactions::RefundService, type: :service do
  subject(:service) do
    described_class.new(transaction_params:,
                        transaction:,
                        current_merchant: merchant)
  end

  let(:customer) do
    create(:customer)
  end

  let(:merchant) do
    create(:merchant,
           total_transaction_sum_cents: 10_00)
  end

  let(:transaction) do
    create(:transaction,
           :refunded,
           follow_transaction_id: charge_transaction.id)
  end

  let(:authorize_transaction) do
    create(:transaction,
           :authorized)
  end

  let(:charge_transaction) do
    create(:transaction,
           :charged,
           merchant:,
           customer:,
           follow_transaction_id: authorize_transaction.id)
  end

  let(:transaction_params) do
    { merchant_id: merchant.id,
      amount_cents: 10_00,
      customer_id: customer.id,
      details: 'No details',
      uuid: charge_transaction.uuid }
  end

  it 'is successful' do
    expect do
      service.call
      charge_transaction.reload
      customer.reload
    end.to change(RefundTransaction, :count).by(1)
       .and change(charge_transaction, :status).from('approved').to('refunded')
       .and change(customer, :amount_cents).from(10_000_00).to(10_010_00)
       .and change(merchant, :total_transaction_sum_cents).from(10_00).to(0)

    expect(service).to be_success
  end

  context 'with errors' do
    context 'when invalid params' do
      let(:customer) do
        create(:customer,
               amount_cents: 9_00)
      end

      context 'when invalid customer' do
        let(:transaction_params) do
          { merchant_id: merchant.id,
            amount_cents: 100_000,
            customer_id: 'invalid',
            details: 'No details' }
        end

        it do
          expect do
            service.call
          end.to change(transaction, :status).from('approved').to('error')

          expect(service).not_to be_success
          expect(service.errors[:base]).to include('Customer does not exist')
        end
      end

      context 'when invalid transaction' do
        let(:transaction_params) do
          { merchant_id: merchant.id,
            amount_cents: 100_000,
            customer_id: customer.id,
            details: 'No details',
            uuid: 'invalid' }
        end

        it do
          service.call

          expect(service).not_to be_success
          expect(service.errors[:base]).to include('Transaction does not exist')
        end

        context 'when charged transaction already refunded' do
          let(:charge_transaction) do
            create(:transaction,
                   :charged,
                   status: 'refunded',
                   merchant:,
                   customer:,
                   follow_transaction_id: authorize_transaction.id)
          end

          let(:transaction_params) do
            { merchant_id: merchant.id,
              amount_cents: 10_00,
              customer_id: customer.id,
              details: 'No details',
              uuid: charge_transaction.uuid }
          end

          it do
            service.call

            expect(service).not_to be_success
            expect(service.errors[:base]).to include('Already refunded')
          end
        end
      end
    end
  end
end
