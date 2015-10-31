require 'test_helper'

Rails.application.routes.disable_clear_and_finalize = true
Rails.application.routes.draw do
  resources :admin_controller_test do
    get :index, on: :collection
  end
end

class AdminControllerTestController < ::AdminController
  def index
    head :ok
  end
end

class AdminControllerTest < ActionController::TestCase
  tests AdminControllerTestController

  test "must be logged in" do
    get :index

    assert_redirected_to new_session_path
  end

  test "must be an admin" do
    sign_in_as(users(:lawyer))

    get :index

    assert_redirected_to new_session_path
  end

  test "GET new renders" do
    sign_in_as(users(:admin))

    get :new

    assert_response :ok
  end

  test "POST create makes an approved admin" do
    sign_in_as(users(:admin))

    password = 'blabla'

    assert_difference 'Admin.count', +1 do
      post(:create, admin: {
        email: 'admin@test.com',
        name: 'Admin name'
      })
    end

    admin = Admin.last
    assert_equal 'admin@test.com', admin.email
    assert admin.approved
    assert_equal 'Admin name', admin.name
  end
end
