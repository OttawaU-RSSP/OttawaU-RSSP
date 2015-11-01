class IntakeForm
  include ActiveModel::Model

  attr_accessor :name,
                :address_line_1,
                :address_line_2,
                :city,
                :province,
                :postal_code,
                :phone,
                :email,
                :citizenship_status,
                :group_size,
                :sah_connection,
                :interpreter_needed,
                :sufficient_resources,
                :criminal_record,
                :connected_to_refugee,
                :refugee_outside_country_of_origin,
                :refugee_connection_type,
                :application,
                :sponsor_group

  validates :citizenship_status, inclusion: { in: SponsorGroup::CITIZENSHIP_STATUSES }
  validates :name, :email, :phone, presence: true

  delegate :persisted?, to: :application, allow_nil: true

  def self.from_application(application)
    sponsor_group = application.sponsor_group

    new.tap do |form|
      form.name                              = sponsor_group.name
      form.address_line_1                    = sponsor_group.address_line_1
      form.address_line_2                    = sponsor_group.address_line_2
      form.city                              = sponsor_group.city
      form.province                          = sponsor_group.province
      form.postal_code                       = sponsor_group.postal_code
      form.phone                             = sponsor_group.phone
      form.email                             = sponsor_group.email
      form.citizenship_status                = sponsor_group.citizenship_status
      form.group_size                        = sponsor_group.group_size
      form.sah_connection                    = sponsor_group.sah_connection
      form.interpreter_needed                = sponsor_group.interpreter_needed
      form.sufficient_resources              = sponsor_group.sufficient_resources
      form.criminal_record                   = sponsor_group.criminal_record
      form.connected_to_refugee              = sponsor_group.connected_to_refugee
      form.refugee_outside_country_of_origin = sponsor_group.refugee_outside_country_of_origin
      form.refugee_connection_type           = sponsor_group.refugee_connection_type
      form.application                       = application
    end
  end

  def save
    return false unless valid?

    if persisted?
      sponsor_group = application.sponsor_group
      sponsor_group.update_attributes(attributes)
    else
      sponsor_group = SponsorGroup.create(attributes)
      sponsor_group.create_application

      notify_admin(sponsor_group)
    end

    true
  end

  private

  def attributes
    {
      name: name,
      address_line_1: address_line_1,
      address_line_2: address_line_2,
      city: city,
      province: province,
      postal_code: postal_code,
      phone: phone,
      email: email,
      citizenship_status: citizenship_status,
      group_size: group_size,
      sah_connection: sah_connection,
      interpreter_needed: interpreter_needed,
      sufficient_resources: sufficient_resources,
      criminal_record: criminal_record,
      connected_to_refugee: connected_to_refugee,
      refugee_outside_country_of_origin: refugee_outside_country_of_origin,
      refugee_connection_type: refugee_connection_type
    }
  end

  def notify_admin(sponsor_group)
    AdminMailer.intake_form_submitted(sponsor_group).deliver_now
  end
end
