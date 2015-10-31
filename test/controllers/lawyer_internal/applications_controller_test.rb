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

  test "#PUT mark_lawyer_review_passed marks lawyer review as passed and notifies" do
    @application.state = "completed"
    @application.save

    put :mark_lawyer_review_passed, id: @application.id

    assert @application.reload.lawyer_reviewed?
    assert_equal "Lawyer review passed", flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end

  test "#PUT mark_expert_review_passed marks expert review as passed and notifies" do
    @application.state = "lawyer_reviewed"
    @application.save

    put :mark_expert_review_passed, id: @application.id

    assert @application.reload.expert_reviewed?
    assert_equal "Expert review passed", flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end

  test "#PUT mark_submitted marks submitted and notifies" do
    @application.state = "expert_reviewed"
    @application.save

    put :mark_submitted, id: @application.id

    assert @application.reload.submitted?
    assert_equal "Application submitted", flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end

  test "#PUT mark_accepted marks accepted and notifies" do
    @application.state = "submitted"
    @application.save

    put :mark_accepted, id: @application.id

    assert @application.reload.accepted?
    assert_equal "Application accepted", flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end

  test "#PUT mark_travel_booked marks travel booked and notifies" do
    @application.state = "accepted"
    @application.save

    put :mark_travel_booked, id: @application.id

    assert @application.reload.travel_booked?
    assert_equal "Travel booked", flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end
end
