require 'rails_helper'

RSpec.describe WelcomeController do
  it_behaves_like 'render template', :index
end
