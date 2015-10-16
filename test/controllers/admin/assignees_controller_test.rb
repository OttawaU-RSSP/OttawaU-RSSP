require 'test_helper'

class Admin::AssigneesControllerTest < ActionController::TestCase
  attr_reader :user, :application, :lawyer

  setup do
    @user = users(:admin)
    @application = applications(:in_progress)
    @lawyer = users(:lawyer)

    sign_in_as(@user)
  end

  test "POST #create associates lawyer to application and makes primary" do
    assert_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: lawyer.id }
    end

    assert application.assignees.where(user: lawyer).exists?

    assert_redirected_to admin_application_path(application)
    assert_equal 'Successfully assigned lawyer.', flash[:notice]
  end

  test "POST #create handles invalid lawyer" do
    assert_no_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: 1000 }
    end

    assert_redirected_to admin_application_path(application)
    assert_equal 'Failed to assign lawyer', flash[:error]
  end

  test "DELETE #destroy removes assignee" do
    assignee = application.assignees.create!(user: lawyer)

    assert_difference 'application.assignees.count', -1 do
      delete :destroy, id: assignee.id
    end

    assert_redirected_to admin_application_path(application)
  end
end
