require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "#GET new renders" do
    get :new

    assert_response :ok
  end

  test "#POST create signs in with valid user" do
    post :create, session: { email: 'david.attenborough@bbc.co.uk', password: 'test' }

    assert_redirected_to lawyer_internal_root_path
  end

  test "#POST renders form if invalid user" do
    post :create, session: { email: 'invalid@user.com', password: 'wrong' }

    assert_response :unauthorized
    assert_template :new
    assert_equal "Invalid email/password", flash[:notice]
  end

  test "#GET activate finds user and present update password form" do
    user = users(:lawyer)
    user.activation_token = "token"
    user.save

    get :activate, token: user.activation_token

    assert_response :ok
    assert_template :activate
    assert_nil assigns(:error)
  end

  test "#GET activate displays error if cannot find user" do
    get :activate, token: "nonexisting token"

    assert_response :ok
    assert_template :activate
    assert_equal "Failed to activate your account. Contact the application admin", assigns(:error)
  end
end
