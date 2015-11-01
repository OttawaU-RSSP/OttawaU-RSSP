require 'test_helper'

class MeetingNotesFormTest < ActiveSupport::TestCase
  test "saving the meeting notes form updates the sponsor group" do
    application = applications(:in_progress)
    sponsor_group = application.sponsor_group

    meeting_notes_form = MeetingNotesForm.new(meeting_notes_form_attributes)
    meeting_notes_form.application = application

    meeting_notes_form.save

    sponsor_group.reload
    assert_equal meeting_notes_form_attributes[:public_meeting_notes], sponsor_group.public_meeting_notes
    assert_equal meeting_notes_form_attributes[:private_meeting_notes], sponsor_group.private_meeting_notes
  end

  test "from_application populates a meeting notes form from an application" do
    application = applications(:in_progress)
    sponsor_group = application.sponsor_group

    sponsor_group.public_meeting_notes = meeting_notes_form_attributes[:public_meeting_notes]
    sponsor_group.private_meeting_notes = meeting_notes_form_attributes[:private_meeting_notes]
    sponsor_group.save

    form = MeetingNotesForm.from_application(application)

    assert_equal sponsor_group.public_meeting_notes, form.public_meeting_notes
    assert_equal sponsor_group.private_meeting_notes, form.private_meeting_notes
  end

  private

  def meeting_notes_form_attributes
    {
      public_meeting_notes: 'public notes',
      private_meeting_notes: 'private notes',
    }
  end
end
