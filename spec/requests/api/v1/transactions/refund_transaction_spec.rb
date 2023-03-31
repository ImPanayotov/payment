describe 'POST /api/v1/transactions/refund_transaction' do
  let(:merchant) do
    create(:merchant)
  end

  let(:customer) do
    create(:customer)
  end

  let(:amount_cents) do
    2000_00
  end

  let(:authorize_transaction) do
    create(:transaction,
           :authorized,
           merchant: merchant,
           customer: customer,
           amount_cents: amount_cents)

  end

  let(:charge_transaction) do
    create(:transaction,
           :charged,
           merchant: merchant,
           customer: customer,
           amount_cents: amount_cents)
  end

  let(:params) do
    { transaction: { amount_cents: amount_cents,
                     customer_id: customer.id,
                     details: 'No details',
                     type: 'RefundTransaction' } }
  end

  before do
    sign_in(merchant)
  end

  context 'with valid params' do
    it 'creates refund transaction' do
      expect do
        post "/api/v1/transactions/#{charge_transaction.uuid}/refund_transaction", params:
      end.to change(RefundTransaction, :count).by(1)

      charge_transaction.reload

      expect(RefundTransaction.last.status).to eq('approved')
      expect(charge_transaction.status).to eq('refunded')
      expect(response.status).to eq(201)
    end
  end

  context "with invalid params" do
    context 'when amount is incorrect' do
      let(:invalid_amount_cents) do
        Money.new(1000_00)
      end

      let(:params) do
        { transaction: { amount_cents: invalid_amount_cents,
                         customer_id: customer.id,
                         details: 'No details',
                         type: 'RefundTransaction' } }
      end


      it do
        expect do
          post "/api/v1/transactions/#{charge_transaction.uuid}/refund_transaction", params:
        end.to change(RefundTransaction, :count).by(1)

        charge_transaction.reload

        expect(RefundTransaction.last.status).to eq('error')
        expect(charge_transaction.status).to eq('approved')
        expect(response.status).to eq(422)
      end
    end

    context 'when customer is incorrect' do
      let(:new_customer) do
        create(:customer)
      end

      let(:params) do
        { transaction: { amount_cents: amount_cents,
                         customer_id: new_customer.id,
                         details: 'No details',
                         type: 'RefundTransaction' } }
      end

      it do
        expect do
          post "/api/v1/transactions/#{charge_transaction.uuid}/refund_transaction", params:
        end.to change(RefundTransaction, :count).by(1)

        charge_transaction.reload

        expect(RefundTransaction.last.status).to eq('error')
        expect(charge_transaction.status).to eq('approved')
        expect(response.status).to eq(422)
      end
    end
  end
end
