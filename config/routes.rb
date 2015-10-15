Rails.application.routes.draw do
  root to: 'home#index'

  namespace :legal do
    resources :applications, only: [:index]
  end
end
