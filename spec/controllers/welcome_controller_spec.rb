require 'rails_helper'

RSpec.describe Admin::WelcomeController do
  include_context 'login as admin'
  it_behaves_like 'render template', :index
end
