require 'test_helper'

class LawyerInternal::ApplicationsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:lawyer)
    sign_in_as(user)

    @application = applications(:in_progress)
    Assignee.create(user_id: @user.id, application_id: @application.id, primary: true)
  end

  test "GET #index renders" do
    get :index

    assert_response :ok
  end

  test "must be lawyer" do
    sign_in_as(users(:sponsor))

    get :index

    assert_redirected_to new_session_path
  end

  test "must be approved" do
    user.update_column(:approved, false)

    sign_in_as(user)

    get :index

    assert_redirected_to new_session_path
  end
end
