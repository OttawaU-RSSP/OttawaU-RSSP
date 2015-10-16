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

  test "PUT #assign associates lawyer to application and makes primary" do
    application = applications(:in_progress)
    lawyer = users(:lawyer)

    assert_difference 'application.assignees.count' do
      put :assign, id: application.id, user_id: lawyer.id
    end

    assert application.assignees.where(user: lawyer).exists?

    assert_redirected_to admin_application_path(application)
    assert_equal 'Successfully assigned lawyer.', flash[:notice]
  end

  test "PUT #assign handles invalid lawyer" do
    application = applications(:in_progress)
    lawyer = users(:lawyer)

    assert_no_difference 'application.assignees.count' do
      put :assign, id: application.id, user_id: 1000
    end

    assert_redirected_to admin_application_path(application)
    assert_equal 'Failed to assign lawyer', flash[:error]
  end
end
