require 'test_helper'

class Legal::ApplicationsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:lawyer)
    sign_in_as(user)
  end

  test "GET #index renders" do
    get :index

    assert_response :ok
  end
end
