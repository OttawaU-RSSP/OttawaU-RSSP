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

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_lawyer_review_passed, id: @application.id
    end

    assert @application.reload.lawyer_reviewed?
    assert_equal "Lawyer review passed", flash[:notice]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_lawyer_review_passed fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_lawyer_review_passed, id: @application.id
    end

    assert @application.reload.in_progress?
    assert_equal "Failed to complete lawyer review. Application cannot transition from in progress to lawyer reviewed", flash[:error]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_expert_review_passed marks expert review as passed and notifies" do
    @application.state = "lawyer_reviewed"
    @application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_expert_review_passed, id: @application.id
    end

    assert @application.reload.expert_reviewed?
    assert_equal "Expert review passed", flash[:notice]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_expert_review_passed fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_expert_review_passed, id: @application.id
    end

    assert @application.reload.in_progress?
    assert_equal "Failed to complete expert review. Application cannot transition from in progress to expert reviewed", flash[:error]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_submitted marks submitted and notifies" do
    @application.state = "expert_reviewed"
    @application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_submitted, id: @application.id
    end

    assert @application.reload.submitted?
    assert_equal "Application submitted", flash[:notice]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_submitted fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_submitted, id: @application.id
    end

    assert @application.reload.in_progress?
    assert_equal "Failed to submit application. Application cannot transition from in progress to submitted", flash[:error]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_accepted marks accepted and notifies" do
    @application.state = "submitted"
    @application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_accepted, id: @application.id
    end

    assert @application.reload.accepted?
    assert_equal "Application accepted", flash[:notice]
    assert_redirected_to legal_internal_application_path(@application)
  end

  test "#PUT mark_accepted fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_accepted, id: @application.id
    end

    assert @application.reload.in_progress?
    assert_equal "Failed to accept application. Application cannot transition from in progress to accepted", flash[:error]
    assert_redirected_to legal_internal_application_path(@application)
  end
end
