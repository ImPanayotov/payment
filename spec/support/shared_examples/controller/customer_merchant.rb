shared_examples 'customer merchant' do |scope|
  include_context 'customer merchant context'

  let(:account_type) do
    create(scope)
  end

  it_behaves_like 'render template', :index

  it_behaves_like 'render template', :show do
    let(:params) do
      { id: account_type.id}
    end
  end

  it_behaves_like 'render template', :edit do
    let(:params) do
      { id: account_type.id}
    end
  end

  it_behaves_like 'render template', :new

  describe '#update' do
    let(:params) do
      { id: account_type.id,
        scope => { email: account_type.email } }
    end

    before do
      patch :update, params:
    end

    it "redirects to updated template" do
      expect(response).to redirect_to(send("admin_#{scope}_path"))
    end
  end

  describe '#create' do
    before do
      post :create, params: send("#{scope}_params")
    end

    context "redirects to created template" do
      let(:account_type) do
        scope.to_s.classify.constantize.last
      end

      it "redirects to created template" do
        expect(response).to redirect_to(send("admin_#{scope}_path", account_type))
      end
    end
  end

  describe '#destroy' do
    let(:params) do
      { id: account_type.id }
    end

    before do
      delete :destroy, params:
    end

    it "redirects to index template" do
      expect(response).to redirect_to(send("admin_#{scope.to_s.pluralize}_path"))
    end
  end
end
