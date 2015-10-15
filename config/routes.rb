Rails.application.routes.draw do
  root to: 'home#index'

  namespace :legal do
    resources :applications, only: [:index]
  end

  controller :sponsor_groups do
    get :intake_form
    post :save_intake
  end
end
