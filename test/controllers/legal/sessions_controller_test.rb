require 'test_helper'

class Legal::SessionsControllerTest < ActionController::TestCase
  test "#GET new renders" do
    get :new

    assert_response :ok
  end

  test "#POST create signs in with valid user" do
    post :create, session: { email: 'david.attenborough@bbc.co.uk', password: 'test' }

    assert_redirected_to legal_applications_path
  end

  test "#POST renders form if invalid user" do
    post :create, session: { email: 'invalid@user.com', password: 'wrong' }

    assert_response :unauthorized
    assert_template :new
  end
end
