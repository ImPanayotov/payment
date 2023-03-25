Rails.application.routes.draw do
  root 'welcome#index'

  resources :merchants
  resources :customers
  resources :transactions, only: [:index]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :transactions, only: %i[] do
        post :authorize_transaction, on: :collection
        post :refund_transaction, on: :member
      end
    end
  end

  resources :transactions, only: %i[] do
    post :authorize, on: :collection
    post :refund, on: :member
  end

  scope :api, defaults: { format: :json } do
    scope :v1 do
      devise_for :merchants,
                 defaults: { format: :json },
                 path: '',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   sessions: 'api/v1/merchants/sessions',
                   registrations: 'api/v1/merchants/registrations'
                 }
    end
  end
end
