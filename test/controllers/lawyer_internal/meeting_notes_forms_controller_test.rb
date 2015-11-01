require 'test_helper'

class LawyerInternal::MeetingNotesFormsControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:lawyer)
    sign_in_as(user)

    @application = applications(:in_progress)
    Assignee.create(user_id: @user.id, application_id: @application.id, primary: true)
  end

  test 'PUT #update updates a sponsor group' do
    sponsor_group = @application.sponsor_group
    put(:update, meeting_notes_form: attributes)

    sponsor_group.reload
    assert_equal attributes[:private_meeting_notes], sponsor_group.private_meeting_notes
    assert_equal attributes[:public_meeting_notes], sponsor_group.public_meeting_notes

    assert_equal 'Successfully updated meeting notes.', flash[:notice]
    assert_redirected_to lawyer_internal_application_path(@application)
  end

  private

  def attributes
    {
      private_meeting_notes: "New private notes",
      public_meeting_notes: "New public notes",
      application_id: @application.id
    }
  end
end
