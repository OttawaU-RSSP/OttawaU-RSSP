Rails.application.routes.draw do
  root to: 'home#index'

  scope '/apply' do
    resources :lawyers, path: 'lawyer', path_names: {new: ""}, only: %i|new create|
  end

  resource :session, only: [:new, :create, :destroy]

  namespace :legal do
    resources :applications, only: [:index, :show]

    root 'applications#index'
  end

  namespace :admin do
    resources :applications, only: [:index, :show]
    resources :assignees, only: [:create, :destroy]

    resources :users, only: [:index] do
      member do
        put :approve
      end
    end

    root 'applications#index'
  end

  resource :intake_forms, only: [:new, :create]
end
