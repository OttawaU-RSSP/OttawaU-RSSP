require 'test_helper'

class SponsorGroupTest < ActiveSupport::TestCase
  test "saving the intake form creates a sponsor" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference "SponsorGroup.count", +1 do
      intake_form.save
    end
  end

  test "saving the intake form creates an application" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference "Application.count", +1 do
      intake_form.save
    end
  end

  test "saving the intake form notifies admin" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      intake_form.save
    end
  end

  private

  def intake_form_attributes
    {
      name: 'One',
      address_line_1: "Address 1",
      address_line_2: "Address 2",
      city: "City",
      postal_code: "Postal code",
      phone: "Phone",
      email: "Email",
      citizenship_status: "Canadian Citizen",
      group_size: 5,
      interpreter_needed: false,
      sufficient_resources: true,
      criminal_record: false,
      connected_to_refugee: true,
      refugee_outside_country_of_origin: false,
      refugee_connection_type: "Sister",
    }
  end
end
