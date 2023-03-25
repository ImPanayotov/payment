module Api
  module V1
    module Merchants
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, options = {})
          render json: { status: { code: 200,
                                   message: "#{resource.email} signed in successfully!",
                                   data: resource } },
                 status: :ok
        end

        def respond_to_on_destroy
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                                   Rails.application.credentials.fetch(:secret_key_base)).first

          current_merchant = Merchant.find(jwt_payload['sub'])

          if current_merchant
            render json: { status: 200,
                           message: "[#{current_merchant.email}] signed out successfully" },
                   status: :ok
          else
            render json: { status: 401,
                           message: "[#{current_merchant.email}] has no active session" },
                   status: :unauthorized
          end
        end
      end
    end
  end
end
