class IntakeForm
  include ActiveModel::Model

  attr_accessor :name,
                :address_line_1,
                :address_line_2,
                :city,
                :postal_code,
                :phone,
                :email,
                :citizenship_status,
                :group_size,
                :interpreter_needed,
                :sufficient_resources,
                :criminal_record,
                :connected_to_refugee,
                :refugee_outside_country_of_origin,
                :refugee_connection_type

  validates :citizenship_status, inclusion: { in: SponsorGroup::CITIZENSHIP_STATUSES }
  validates :name, :email, :phone, presence: true

  def save
    return false unless valid?

    sponsor_group = SponsorGroup.new(attributes)
    sponsor_group.save
  end

  private

  def attributes
    {
      name: name,
      address_line_1: address_line_1,
      address_line_2: address_line_2,
      city: city,
      postal_code: postal_code,
      phone: phone,
      email: email,
      citizenship_status: citizenship_status,
      group_size: group_size,
      interpreter_needed: interpreter_needed,
      sufficient_resources: sufficient_resources,
      criminal_record: criminal_record,
      connected_to_refugee: connected_to_refugee,
      refugee_outside_country_of_origin: refugee_outside_country_of_origin,
      refugee_connection_type: refugee_connection_type
    }
  end
end
