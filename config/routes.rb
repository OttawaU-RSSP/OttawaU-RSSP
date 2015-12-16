Rails.application.routes.draw do
  root to: 'home#index'

  scope '/apply' do
    resources :lawyers, path: 'lawyer', path_names: {new: ""}, only: %i|new create|
    resources :students, path: 'student', path_names: {new: ""}, only: %i|new create|
  end

  namespace :lawyer_internal do
    resources :applications, only: [:index]

    root 'applications#index'
  end

  namespace :student_internal do
    resources :applications, only: [:index]

    root 'applications#index'
  end

  namespace :legal_internal do
    resources :assignees, only: [:create, :destroy]
    resource :meeting_notes_form, only: [:update]
    resource :follow_up_call_form, only: [:edit, :update]
    resources :applications, only: [:show] do
      member do
        put :reject
        put :approve_follow_up_call
        put :approve_intake_form
        put :mark_intake_discussion_complete
        put :mark_lawyer_matched
        put :mark_completed
        put :mark_lawyer_review_passed
        put :mark_expert_review_passed
        put :mark_submitted
        put :mark_accepted
      end
    end
  end

  namespace :admin do
    resource :home, only: [:index]

    resources :lawyers, only: [:index, :show, :destroy] do
      member do
        put :approve
        put :add_private_notes
      end
    end

    resources :students, only: [:index, :show, :destroy] do
      member do
        put :approve
        put :add_private_notes
      end
    end

    resources :admins, only: [:index, :create, :show] do
      member do
        patch :update_password
        patch :reactivate
      end
    end

    resources :applications, only: [:index, :destroy]

    root 'home#index'
  end

  resource :intake_form, only: [:new, :create, :update]

  resources :sponsors, only: [:show] do
    member do
      patch :update_password
    end
  end

  resources :students, only: [:show] do
    member do
      patch :update_password
    end
  end

  resources :lawyers, only: [:show] do
    member do
      patch :update_password
    end
  end

  resource :session, only: [:new, :create, :destroy] do
    member do
      get :activate
    end
  end
end
