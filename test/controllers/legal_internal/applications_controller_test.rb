require 'test_helper'

class LegalInternal::ApplicationsControllerTest < ActionController::TestCase
  attr_reader :user, :application

  setup do
    @user = users(:admin)
    @application = applications(:in_progress)
    request.env["HTTP_REFERER"] = "http://test.host/legal_internal/applications/#{application.id}"

    sign_in_as(@user)
  end

  test "GET #show renders" do
    get :show, id: application.id

    assert_response :ok
  end

  test "PUT #approve_intake_form marks intake application as pending follow up and redirects to show" do
    application.state = :intake
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :approve_intake_form, id: application.id
    end

    assert_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.pending_follow_up?
  end

  test "PUT #approve_intake_form fails for in_progress application" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :approve_intake_form, id: application.id
    end

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.in_progress?
    refute_nil flash[:error]
  end

  test "PUT #mark_intake_discussion_complete marks application as followed up, and redirects to show" do
    application.state = :pending_follow_up
    application.save

    put :mark_intake_discussion_complete, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.followed_up?
    assert_nil flash[:error]
  end

  test "PUT #mark_intake_discussion_complete fails for in_progress application" do
    put :mark_intake_discussion_complete, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.in_progress?
    refute_nil flash[:error]
  end

  test "PUT #approve_intake_discussion marks application as follow up call approved, creates a sponsor login and notifies, and redirects to show" do
    application.state = :followed_up
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      assert_difference 'Sponsor.count', +1 do
        put :approve_intake_discussion, id: application.id
      end
    end

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.pending_lawyer_match?
    assert_nil flash[:error]
  end

  test "PUT #approve_intake_discussion fails for in_progress application" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :approve_intake_discussion, id: application.id
    end

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.in_progress?
    refute_nil flash[:error]
  end

  test "PUT #mark_lawyer_matched marks application as in_progress, and redirects to show" do
    application.state = :pending_lawyer_match
    application.save

    put :mark_lawyer_matched, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.in_progress?
    assert_nil flash[:error]
  end

  test "PUT #mark_lawyer_matched fails for intake application" do
    application.state = :intake
    application.save

    put :mark_lawyer_matched, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.intake?
    refute_nil flash[:error]
  end

  test "PUT #mark_completed marks application as completed, and redirects to show" do
    application.state = :in_progress
    application.save

    put :mark_completed, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.completed?
    assert_nil flash[:error]
  end

  test "PUT #mark_completed fails for intake application" do
    application.state = :intake
    application.save

    put :mark_completed, id: application.id

    assert_redirected_to legal_internal_application_path(application)
    assert application.reload.intake?
    refute_nil flash[:error]
  end

  test "#PUT mark_lawyer_review_passed marks lawyer review as passed and notifies" do
    application.state = :completed
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_lawyer_review_passed, id: application.id
    end

    assert application.reload.lawyer_reviewed?
    assert_redirected_to legal_internal_application_path(application)
    assert_nil flash[:error]
  end

  test "#PUT mark_lawyer_review_passed fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_lawyer_review_passed, id: application.id
    end

    assert application.reload.in_progress?
    refute_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "#PUT mark_expert_review_passed marks expert review as passed and notifies" do
    application.state = :lawyer_reviewed
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_expert_review_passed, id: application.id
    end

    assert application.reload.expert_reviewed?
    assert_redirected_to legal_internal_application_path(application)
    assert_nil flash[:error]
  end

  test "#PUT mark_expert_review_passed fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_expert_review_passed, id: application.id
    end

    assert application.reload.in_progress?
    refute_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "#PUT mark_submitted marks submitted and notifies" do
    application.state = :expert_reviewed
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_submitted, id: application.id
    end

    assert application.reload.submitted?
    assert_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "#PUT mark_submitted fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_submitted, id: application.id
    end

    assert application.reload.in_progress?
    refute_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "#PUT mark_accepted marks accepted and notifies" do
    application.state = :submitted
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :mark_accepted, id: application.id
    end

    assert application.reload.accepted?
    assert_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "#PUT mark_accepted fails for in progress applications" do
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :mark_accepted, id: application.id
    end

    assert application.reload.in_progress?
    refute_nil flash[:error]
    assert_redirected_to legal_internal_application_path(application)
  end

  test "PUT #reject marks application rejected and redirects to admin application index if user is admin" do
    Application.any_instance.expects(:reject)

    application = applications(:in_progress)
    put :reject, id: application.id

    assert_redirected_to admin_applications_path
    assert_nil flash[:error]
  end

  test "PUT #reject marks application rejected and redirects to lawyer application index if user is lawyer" do
    user = users(:lawyer)
    sign_in_as(user)
    application.assign(user)

    Application.any_instance.expects(:reject)

    application = applications(:in_progress)
    put :reject, id: application.id

    assert_redirected_to lawyer_internal_applications_path
    assert_nil flash[:error]
  end

  test "PUT #reject marks application rejected and redirects to student application index if user is student" do
    user = users(:student)
    sign_in_as(user)
    application.assign(user)

    Application.any_instance.expects(:reject)

    application = applications(:in_progress)
    put :reject, id: application.id

    assert_redirected_to student_internal_applications_path
    assert_nil flash[:error]
  end

  test "sponsors are denied access" do
    user = users(:sponsor)
    sign_in_as(user)

    get :show, id: application.id
    assert_redirected_to new_session_path
  end

  test "lawyers not assigned to application are denied access" do
    user = users(:lawyer)
    sign_in_as(user)

    refute User.assigned_to(application).include? user

    get :show, id: application.id
    assert_redirected_to new_session_path
  end

  test "students not assigned to application are denied access" do
    user = users(:student)
    sign_in_as(user)

    refute User.assigned_to(application).include? user

    get :show, id: application.id
    assert_redirected_to new_session_path
  end
end
