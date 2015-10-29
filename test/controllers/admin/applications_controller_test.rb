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

  test "PUT #approve_follow_up_call marks application as follow up call approved and redirects to show" do
    Application.any_instance.expects(:approve_follow_up_call)

    application = applications(:in_progress)
    put :approve_follow_up_call, id: application.id

    assert_redirected_to admin_application_path(application)
  end

  test "PUT #reject marks application rejected and redirects to show" do
    Application.any_instance.expects(:reject)

    application = applications(:in_progress)
    put :reject, id: application.id

    assert_redirected_to admin_application_path(application)
  end
end
