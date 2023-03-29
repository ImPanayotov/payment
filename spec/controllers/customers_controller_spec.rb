require 'rails_helper'

RSpec.describe Admin::CustomersController do
  include_context 'login as admin'
  include_context 'customer merchant', 'customer'
end
