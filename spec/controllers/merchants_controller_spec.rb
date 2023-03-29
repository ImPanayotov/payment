require 'rails_helper'

RSpec.describe Admin::MerchantsController do
  include_context 'login as admin'
  include_context 'customer merchant', 'merchant'
end
