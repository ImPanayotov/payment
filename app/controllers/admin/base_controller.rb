class Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin_user!

    def policy_scope(scope)
      super([:admin, scope])
    end

    def authorize(record, query = nil)
      super([:admin, record], query)
    end

    def pundit_user
      current_admin_user
    end
  end
end
