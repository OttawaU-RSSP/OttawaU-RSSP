Rails.application.routes.draw do
  root to: 'home#index'

  namespace :legal do
    resources :applications, only: [:index]
    resource :session, only: [:new, :create, :destroy]
  end

  resource :intake_forms, only: [:new, :create]
end
