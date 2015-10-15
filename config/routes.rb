Rails.application.routes.draw do
  root to: 'home#index'

  resource :session, only: [:new, :create, :destroy]

  namespace :legal do
    resources :applications, only: [:index]

    root 'applications#index'
  end

  namespace :admin do
    resources :users, only: [:index] do
      member do
        put :approve
      end
    end

    root 'users#index'
  end
end
