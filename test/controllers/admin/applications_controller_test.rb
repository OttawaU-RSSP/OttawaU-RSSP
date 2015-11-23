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

  test "PUT #approve_follow_up_call marks application as follow up call approved, creates a sponsor login and notifies, and redirects to show" do
    application = applications(:in_progress)
    application.state = :followed_up
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      assert_difference 'Sponsor.count', +1 do
        put :approve_follow_up_call, id: application.id
      end
    end

    assert_redirected_to admin_application_path(application)
    assert application.reload.pending_lawyer_match?
  end

  test "PUT #approve_follow_up_call fails for in_progress application" do
    application = applications(:in_progress)

    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :approve_follow_up_call, id: application.id
    end

    assert_redirected_to admin_application_path(application)
    assert application.reload.in_progress?
    assert_equal "Failed to approve intake discussion. Application cannot transition from in progress to in progress", flash[:error]
  end

  test "PUT #approve_intake_form marks intake application as pending follow up and redirects to show" do
    application = applications(:in_progress)
    application.state = :intake
    application.save

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :approve_intake_form, id: application.id
    end

    assert_redirected_to admin_application_path(application)
    assert application.reload.pending_follow_up?
  end

  test "PUT #approve_intake_form fails for in_progress application" do
    application = applications(:in_progress)

    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :approve_intake_form, id: application.id
    end

    assert_redirected_to admin_application_path(application)
    assert application.reload.in_progress?
    assert_equal "Failed to approve intake form. Application cannot transition from in progress to pending follow up", flash[:error]
  end

  test "PUT #reject marks application rejected and redirects to show" do
    Application.any_instance.expects(:reject)

    application = applications(:in_progress)
    put :reject, id: application.id

    assert_redirected_to admin_application_path(application)
  end
end
