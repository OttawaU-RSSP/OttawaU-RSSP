require 'test_helper'

class LegalInternal::FollowUpCallFormsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:admin)
    @application = applications(:in_progress)
    @application.state = "pending_follow_up"
    @application.save

    sign_in_as(@user)
  end

  test 'GET #edit renders' do
    get :edit, application_id: @application.id

    assert_response :ok
  end

  test 'PUT updates a sponsor group' do
    sponsor_group = @application.sponsor_group

    put(:update, follow_up_call_form: attributes)

    sponsor_group.reload
    assert_equal attributes[:public_notes], sponsor_group.public_notes
    assert_equal attributes[:private_notes], sponsor_group.private_notes
    assert_equal true, sponsor_group.proper_group_size
    assert_equal attributes[:refugee_nationality], sponsor_group.refugee_nationality
    assert_equal attributes[:refugee_current_location], sponsor_group.refugee_current_location
    assert_equal false, sponsor_group.connect_refugee_family_in_canada
    assert_equal true, sponsor_group.add_to_refugee_assistance_list
  end

  test 'Update is redirected to the application show if user is admin' do
    put(:update, follow_up_call_form: attributes)
    assert_redirected_to legal_internal_application_path(@application)
  end

  test 'Update is redirected to the application show if user is lawyer and assigned to application' do
    user = users(:lawyer)
    @application.assign(user)
    sign_in_as(user)

    put(:update, follow_up_call_form: attributes)
    assert_redirected_to legal_internal_application_path(@application)
  end

  test 'Update is redirected to the application show if user is student and assigned to application' do
    user = users(:student)
    @application.assign(user)
    sign_in_as(user)

    put(:update, follow_up_call_form: attributes)
    assert_redirected_to legal_internal_application_path(@application)
  end

  test 'Update is redirected to the lawyer applications index user is lawyer and not assigned to application' do
    user = users(:lawyer)
    sign_in_as(user)

    refute User.assigned_to(@application).include? user

    put(:update, follow_up_call_form: attributes)
    assert_redirected_to lawyer_internal_applications_path
  end

  test 'Update is redirected to the student applications index user is student and not assigned to application' do
    user = users(:student)
    sign_in_as(user)

    refute User.assigned_to(@application).include? user

    put(:update, follow_up_call_form: attributes)
    assert_redirected_to student_internal_applications_path
  end

  private

  def attributes
    {
      application_id: @application.id,
      public_notes: 'public notes',
      private_notes: 'private notes',
      proper_group_size: '1',
      refugee_nationality: 'Nationality',
      refugee_current_location: 'Location',
      connect_refugee_family_in_canada: '0',
      add_to_refugee_assistance_list: '1',
    }
  end
end
