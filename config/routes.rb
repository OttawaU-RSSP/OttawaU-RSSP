Rails.application.routes.draw do
  root to: 'home#index'

  namespace :legal do
    resources :applications, only: [:index]
  end

  resource :intake_forms, only: [:new, :create]
end
