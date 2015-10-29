require 'test_helper'

class FollowUpCallFormTest < ActiveSupport::TestCase
  test "saving the follow up call form updates the sponsor group" do
    application = applications(:in_progress)
    sponsor_group = application.sponsor_group

    follow_up_call_form = FollowUpCallForm.new(follow_up_call_form_attributes)
    follow_up_call_form.application = application

    follow_up_call_form.save

    sponsor_group.reload
    assert_equal follow_up_call_form_attributes[:public_notes], sponsor_group.public_notes
    assert_equal follow_up_call_form_attributes[:private_notes], sponsor_group.private_notes
    assert_equal true, sponsor_group.proper_group_size
    assert_equal follow_up_call_form_attributes[:refugee_name], sponsor_group.refugee_name
    assert_equal follow_up_call_form_attributes[:refugee_nationality], sponsor_group.refugee_nationality
    assert_equal follow_up_call_form_attributes[:refugee_current_location], sponsor_group.refugee_current_location
    assert_equal false, sponsor_group.connect_refugee_family_in_canada
    assert_equal false, sponsor_group.connect_refugee_no_family_in_canada
  end

  private

  def follow_up_call_form_attributes
    {
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
