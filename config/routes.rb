Rails.application.routes.draw do
  root to: 'home#index'

  controller :sponsor_groups do
    get :intake_form
    post :save_intake
  end
end
