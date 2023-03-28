require 'rails_helper'

RSpec.describe MerchantsController do
  it_behaves_like 'render template', :index
end
