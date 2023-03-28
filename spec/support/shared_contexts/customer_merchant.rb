shared_context 'customer merchant context' do
  let(:merchant_params) do
    { merchant: { name: 'JohnD Inc.',
                  email: 'j.doe@example.com',
                  password: 'Password123!' } }
  end

  let(:customer_params) do
    { customer: { first_name: 'John',
                  last_name: 'Doe',
                  email: 'j.doe@example.com',
                  phone: '+359111222333',
                  password: 'Password123!' } }
  end
end
