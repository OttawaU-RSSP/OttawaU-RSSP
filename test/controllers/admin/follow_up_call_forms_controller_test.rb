require 'test_helper'

class Admin::FollowUpCallFormsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:admin)
    @application = applications(:in_progress)
    @application.state = "pending_follow_up"
    @application.save

    sign_in_as(@user)
  end

  test 'GET #edit renders' do
    get :edit, follow_up_call_form: { application_id: @application.id }

    assert_response :ok
  end

  test 'PUT updates a sponsor group and marks application as followed up' do
    sponsor_group = @application.sponsor_group

    put(:update, follow_up_call_form: attributes)

    sponsor_group.reload
    assert_equal attributes[:public_notes], sponsor_group.public_notes
    assert_equal attributes[:private_notes], sponsor_group.private_notes
    assert_equal true, sponsor_group.proper_group_size
    assert_equal attributes[:refugee_name], sponsor_group.refugee_name
    assert_equal attributes[:refugee_nationality], sponsor_group.refugee_nationality
    assert_equal attributes[:refugee_current_location], sponsor_group.refugee_current_location
    assert_equal false, sponsor_group.connect_refugee_family_in_canada
    assert_equal false, sponsor_group.connect_refugee_no_family_in_canada
    assert @application.reload.followed_up?

    assert_redirected_to admin_application_path(@application)
  end

  private

  def attributes
    {
      application_id: @application.id,
      public_notes: 'public notes',
      private_notes: 'private notes',
      proper_group_size: '1',
      refugee_name: 'Name',
      refugee_nationality: 'Nationality',
      refugee_current_location: 'Location',
      connect_refugee_family_in_canada: '0',
      connect_refugee_no_family_in_canada: '0'
    }
  end
end
