require 'test_helper'

class Admin::ApplicationsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:admin)

    sign_in_as(@user)
  end

  test "GET #index renders" do
    get :index

    assert_response :ok
  end

  test "GET #show renders" do
    application = applications(:in_progress)

    get :show, id: application.id

    assert_response :ok
  end
end
