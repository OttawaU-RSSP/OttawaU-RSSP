require 'test_helper'

class Legal::ApplicationsControllerTest < ActionController::TestCase
  test "GET #index renders" do
    get :index

    assert_response :ok
  end
end
