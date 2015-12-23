require 'test_helper'

class LegalInternal::AssigneesControllerTest < ActionController::TestCase
  attr_reader :user, :application, :lawyer, :student

  setup do
    @user = users(:admin)
    @application = applications(:in_progress)
    @lawyer = users(:lawyer)
    @student = users(:student)

    sign_in_as(@user)
    request.env["HTTP_REFERER"] = "http://test.host/legal_internal/applications/#{@application.id}"
  end

  test "POST #create associates lawyer to application and makes primary" do
    assert_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: lawyer.id }
    end

    assert application.assignees.where(user: lawyer).exists?

    assert_redirected_to :back
    assert_equal 'Successfully assigned lawyer/student.', flash[:notice]
  end

  test "POST #create handles invalid lawyer" do
    assert_no_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: 1000 }
    end

    assert_redirected_to :back
    assert_equal 'Failed to assign lawyer/student', flash[:error]
  end

  test "Lawyer can associate student to application if they are assigned to the application" do
    application.assign(lawyer)
    sign_in_as(lawyer)

    assert_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: student.id }
    end

    assert application.assignees.where(user: student).exists?

    assert_redirected_to :back
    assert_equal 'Successfully assigned lawyer/student.', flash[:notice]
  end

  test "Lawyer cannot associate student to application if they are not assigned to the application" do
    sign_in_as(lawyer)
    refute User.assigned_to(application).include? lawyer

    assert_no_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: student.id }
    end

    assert_redirected_to :back
    refute_nil flash[:error]
  end

  test "Student cannot create assignees" do
    application.assign(lawyer)
    sign_in_as(student)

    assert_no_difference 'application.assignees.count' do
      post :create, assignee: { application_id: application.id, user_id: student.id }
    end

    assert_redirected_to :back
    refute_nil flash[:error]
  end

  test "DELETE #destroy removes assignee" do
    assignee = application.assignees.create!(user: lawyer)

    assert_difference 'application.assignees.count', -1 do
      delete :destroy, id: assignee.id
    end

    assert_redirected_to :back
  end
end
