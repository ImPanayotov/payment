shared_context 'login as admin' do
  let(:admin) do
    create(:user,
           :admin)
  end

  before do
    sign_in(admin)
  end
end
