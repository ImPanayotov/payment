shared_examples 'admin' do |action|
  describe ".#{action}?" do
    context 'when user is admin' do
      it { is_expected.to permit_action(action) }
    end

    context 'when user is not admin' do
      let(:user) do
        create(:user)
      end

      it { is_expected.to forbid_action(action) }
    end
  end
end
