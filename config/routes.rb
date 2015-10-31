Rails.application.routes.draw do
  root to: 'home#index'

  scope '/apply' do
    resources :lawyers, path: 'lawyer', path_names: {new: ""}, only: %i|new create|
    resources :students, path: 'student', path_names: {new: ""}, only: %i|new create|
  end

  namespace :lawyer_internal do
    resources :applications, only: [:index, :show] do
      member do
        put :mark_lawyer_review_passed
        put :mark_expert_review_passed
        put :mark_submitted
        put :mark_accepted
        put :mark_travel_booked
      end
    end

    root 'applications#index'
  end

  namespace :student_internal do
    resources :applications, only: [:index, :show]

    root 'applications#index'
  end

  namespace :admin do
    resources :assignees, only: [:create, :destroy]
    resource :follow_up_call_form, only: [:edit, :update]
    resource :home, only: [:index]

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

    resources :applications, only: [:index, :show] do
      member do
        put :reject
        put :approve_follow_up_call
      end
    end

    root 'home#index'
  end

  resource :intake_form, only: [:new, :create, :update]
  resources :students, only: [:show]
  resources :lawyers, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resources :admin, only: [:new, :create]
end
