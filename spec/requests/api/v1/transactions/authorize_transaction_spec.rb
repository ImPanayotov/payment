describe 'POST /api/v1/transactions/authorize_transaction' do
  let(:merchant) do
    create(:merchant)
  end

  let(:customer) do
    create(:customer)
  end

  let(:params) do
    { transaction: { amount_cents: 200000,
                     customer_id: customer.id,
                     details: 'No details' } }
  end

  before do
    sign_in(merchant)
  end

  context 'when customer has got enough amount' do
    it 'creates authorize and charge transactions' do
      expect do
        post "/api/v1/transactions/authorize_transaction", params:
      end.to change(AuthorizeTransaction, :count).by(1)
         .and change(ChargeTransaction, :count).by(1)

      expect(AuthorizeTransaction.last.status).to eq('approved')
      expect(ChargeTransaction.last.status).to eq('approved')
      expect(response.status).to eq(201)
    end
  end

  context "when customer hasn't got enough amount" do
    let(:customer) do
      create(:customer, amount_cents: 0)
    end

    it 'creates authorize and reversal transaction' do
      expect do
        post "/api/v1/transactions/authorize_transaction", params:
      end.to change(AuthorizeTransaction, :count).by(1)
         .and change(ReversalTransaction, :count).by(1)

      expect(AuthorizeTransaction.last.status).to eq('reversed')
      expect(ReversalTransaction.last.status).to eq('approved')
      expect(response.status).to eq(201)
    end
  end
end
