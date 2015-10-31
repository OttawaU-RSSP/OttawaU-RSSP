class MeetingNotesForm
  include ActiveModel::Model

  attr_accessor :public_meeting_notes,
                :private_meeting_notes,
                :application,
                :sponsor_group

  def self.from_application(application)
    sponsor_group = application.sponsor_group

    new.tap do |form|
      form.public_meeting_notes = sponsor_group.public_meeting_notes
      form.private_meeting_notes = sponsor_group.private_meeting_notes
      form.application = application
    end
  end

  def save
    return false unless valid?

    @sponsor_group = application.sponsor_group
    @sponsor_group.update_attributes(attributes)

    true
  end

  private

  def attributes
    {
      public_meeting_notes: public_meeting_notes,
      private_meeting_notes: private_meeting_notes,
    }
  end
end
