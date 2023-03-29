require 'rails_helper'

RSpec.describe Admin::MerchantsController do
  include_context 'login as admin'
  it_behaves_like 'render template', :index
end
