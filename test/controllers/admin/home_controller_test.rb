require 'test_helper'

class Admin::HomeControllerTest < ActionController::TestCase
  attr_reader :admin

  setup do
    @admin = users(:admin)

    sign_in_as(@admin)
  end

  test "Get #index redners" do
    get :index

    assert_response :ok
  end
end
