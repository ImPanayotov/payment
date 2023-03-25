module Api
  module V1
    module Merchants
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, options = {})
          if resource.persisted?
            render json: { status: { code: 200,
                                     message: "#{resource.email} signed up successfully!",
                                     data: resource }
            }
          else
            render json: { status: { message: 'Merchant could not be created successfully!',
                                     errors: resource.errors.full_messages } },
                   status: :unprocessable_entity
          end
        end
      end
    end
  end
end
