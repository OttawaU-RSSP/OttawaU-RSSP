class FollowUpCallForm
  include ActiveModel::Model

  attr_accessor :public_notes,
                :private_notes,
                :proper_group_size,
                :refugee_nationality,
                :refugee_current_location,
                :connect_refugee_family_in_canada,
                :add_to_refugee_assistance_list,
                :application,
                :sponsor_group

  def self.from_application(application)
    sponsor_group = application.sponsor_group

    new.tap do |form|
      form.public_notes = sponsor_group.public_notes
      form.private_notes = sponsor_group.private_notes
      form.proper_group_size = sponsor_group.proper_group_size
      form.refugee_nationality = sponsor_group.refugee_nationality
      form.refugee_current_location = sponsor_group.refugee_current_location
      form.connect_refugee_family_in_canada = sponsor_group.connect_refugee_family_in_canada
      form.add_to_refugee_assistance_list = sponsor_group.add_to_refugee_assistance_list
      form.application = application
    end
  end

  def save
    return false unless valid?

    sponsor_group = application.sponsor_group
    sponsor_group.update_attributes(attributes)

    true
  end

  private

  def attributes
    {
      public_notes: public_notes,
      private_notes: private_notes,
      proper_group_size: proper_group_size,
      refugee_nationality: refugee_nationality,
      refugee_current_location: refugee_current_location,
      connect_refugee_family_in_canada: connect_refugee_family_in_canada,
      add_to_refugee_assistance_list: add_to_refugee_assistance_list
    }
  end
end
