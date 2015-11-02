require 'test_helper'

class IntakeFormTest < ActiveSupport::TestCase
  test "saving the intake form creates a sponsor group if application does not already exist" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference "SponsorGroup.count", +1 do
      intake_form.save
    end
  end

  test "saving the intake form creates an application if application does not already exist" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference "Application.count", +1 do
      intake_form.save
    end
  end

  test "saving the intake form notifies admin if application does not already exist" do
    intake_form = IntakeForm.new(intake_form_attributes)

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      intake_form.save
    end
  end

  test "saving the intake form updates the application if the application already exists" do
    application = applications(:in_progress)
    sponsor_group = application.sponsor_group

    intake_form = IntakeForm.new(intake_form_attributes)
    intake_form.application = application

    assert_no_difference 'SponsorGroup.count', +1 do
      intake_form.save
    end

    sponsor_group.reload
    assert_equal intake_form_attributes[:name], sponsor_group.name
  end

  private

  def intake_form_attributes
    {
      name: "New name",
      phone: "18006390666",
      email: "new@email.com",
      address_line_1: "new address 1",
      address_line_2: "new address 2",
      city: "new city",
      province: "Ontario",
      postal_code: "K8J9L0",
      citizenship_status: "Permanent Resident",
      connected_to_refugee: "1",
      refugee_connection_type: "Family",
      refugee_outside_country_of_origin: "1",
      group_size: 3,
      sah_connection: "0",
      interpreter_needed: "0",
      sufficient_resources: "1",
      criminal_record: "0",
    }
  end
end
