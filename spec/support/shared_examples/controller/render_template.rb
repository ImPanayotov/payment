# 'action' - required for all specs, e.g. :index, :show, etc.
#
# 'method' - required for all specs, GET by default
#
# 'params' - the params object passed from the spec;
#            should always be passed through the block of the spec
#
# 'template' - when the template is different from the action
#              otherwise it will fallback to action name
# example:
#   let(:user) { create(:user) }
#
#   it_behaves_like 'render template', :show, method: post, xhr: true do
#     let(params) do
#       { id: user.id }
#     end
#   end

# WARNING: No matter what method type is passed (GET POST PUT PATCH DELETE)
#          the spec will always pass and render the given action template

RSpec.shared_examples 'render template' do |action, method: :get, template: action|
  describe "##{action}" do
    it "renders #{action} template" do
      valid_method?(method)

      passed_params = params if defined?(params)

      send(method, action, params: passed_params)
      expect(response).to render_template(template)
    end

    def valid_method?(method)
      return if %i[get post put patch delete].include?(method.to_sym)

      raise StandardError, 'method not permitted'
    end
  end
end
