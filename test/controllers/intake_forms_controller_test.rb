require 'test_helper'

class IntakeFormsControllerTest < ActionController::TestCase
  setup do
    @application = applications(:in_progress)
  end

  test 'GET #new renders' do
    get :new
    assert_response :ok
  end

  test 'POST #create creates a sponsor group' do
    assert_difference 'SponsorGroup.count', +1 do
      post(:create, intake_form: attributes)
    end

    assert_redirected_to root_path
  end

  test 'PUT #update updates a sponsor group' do
    sponsor_group = @application.sponsor_group
    put(:update, intake_form: attributes)

    sponsor_group.reload
    assert_equal attributes[:name], sponsor_group.name
    assert_equal attributes[:phone], sponsor_group.phone
    assert_equal attributes[:email], sponsor_group.email
    assert_equal attributes[:address_line_1], sponsor_group.address_line_1
    assert_equal attributes[:address_line_2], sponsor_group.address_line_2
    assert_equal attributes[:city], sponsor_group.city
    assert_equal attributes[:province], sponsor_group.province
    assert_equal attributes[:postal_code], sponsor_group.postal_code
    assert_equal attributes[:citizenship_status], sponsor_group.citizenship_status
    assert_equal true, sponsor_group.connected_to_refugee
    assert_equal attributes[:refugee_connection_type], sponsor_group.refugee_connection_type
    assert_equal "Yes", sponsor_group.refugee_outside_country_of_origin
    assert_equal attributes[:group_size], sponsor_group.group_size
    assert_equal false, sponsor_group.sah_connection
    assert_equal false, sponsor_group.interpreter_needed
    assert_equal "Yes", sponsor_group.sufficient_resources
    assert_equal false, sponsor_group.criminal_record

    assert_redirected_to admin_application_path(@application)
  end

  private

  def attributes
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
      refugee_outside_country_of_origin: "Yes",
      group_size: 3,
      sah_connection: "0",
      interpreter_needed: "0",
      sufficient_resources: "Yes",
      criminal_record: "0",
      application_id: @application.id
    }
  end
end
