require 'test_helper'

Rails.application.routes.disable_clear_and_finalize = true
Rails.application.routes.draw do
  resources :legal_controller_test do
    get :index, on: :collection
  end
end

class LegalControllerTestController < ::LegalController
  def index
    head :ok
  end
end

class LegalControllerTest < ActionController::TestCase
  tests LegalControllerTestController

  test "must be logged in" do
    get :index

    assert_redirected_to new_session_path
  end

  test "must be lawyer" do
    sign_in_as(users(:sponsor))

    get :index

    assert_redirected_to new_session_path
  end

  test "must be approved" do
    lawyer = users(:lawyer)
    lawyer.update_column(:approved, false)

    sign_in_as(lawyer)

    get :index

    assert_redirected_to new_session_path
  end
end
