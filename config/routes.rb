Rails.application.routes.draw do
  root to: 'home#index'

  scope '/apply' do
    resources :lawyers, path: 'lawyer', path_names: {new: ""}, only: %i|new create|
    resources :students, path: 'student', path_names: {new: ""}, only: %i|new create|
  end

  namespace :lawyer_internal do
    resources :applications, only: [:index, :show]

    root 'applications#index'
  end

  namespace :student_internal do
    resources :applications, only: [:index, :show]

    root 'applications#index'
  end

  namespace :admin do
    resources :applications, only: [:index, :show]
    resources :assignees, only: [:create, :destroy]

    resources :lawyers, only: [:index, :show] do
      member do
        put :approve
      end
    end

    resources :students, only: [:index, :show] do
      member do
        put :approve
      end
    end

    root 'applications#index'
  end

  resource :intake_form, only: [:new, :create]
  resources :students, only: [:show]
  resources :lawyers, only: [:show]
  resource :session, only: [:new, :create, :destroy]
end
