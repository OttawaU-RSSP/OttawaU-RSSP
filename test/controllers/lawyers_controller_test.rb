require 'test_helper'

class LawyersControllerTest < ActionController::TestCase
  test 'GET #new renders' do
    get :new

    assert_response :ok
  end

  test 'POST create makes an unapproved lawyer with a random password and notifies lawyer' do
    password = 'blabla'

    assert_difference 'Lawyer.count', +1 do
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        post(:create, lawyer: {
          email: 'bouke@test.nl',
          password: password,
          approved: true,
          name: 'Bouke van der Bijl',
          address1: 'Netherlands 1',
          city: 'Amsterdam',
          province: 'North Holland',
          telephone: '0612123817',
          employer_name: 'Zijne Majesteit',
          employer_address: 'Oranjestraat 1',
          employment_type: 'Court',
          practicing: '1',
          year_of_call: '1900',
          law_society_number: 'LSUC',
          areas_of_practice: ['Environment'],
          language_of_practice: 'Dutch',
          experience_with_refugee_sponsorships: '0',
          experience_with_refugee_sponsorships_clarification: '',
          insurance: 'No',
          can_accomodate_meetings: '1',
          areas_of_interest: ['Providing ongoing assistance to sponsors through SSP matching'],
          comments: ''
        })
      end
    end

    lawyer = Lawyer.last
    assert_equal 'bouke@test.nl', lawyer.email
    assert_not_equal password, lawyer.password
    refute lawyer.approved
    assert_equal 'Bouke van der Bijl', lawyer.name
  end

  test 'PATCH update_password updates password, resets activation token, and signs in if password and confirmation match and token matches' do
    lawyer = users(:lawyer)

    params = {
      id: lawyer.id,
      lawyer: {
        password: "New password",
        activation_token: lawyer.activation_token,
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to lawyer_internal_root_path
    refute lawyer.reload.activation_token == params[:lawyer][:activation_token]
  end

  test 'PATCH update_password redirects back if password and confirmation do not match and token matches' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    lawyer = users(:lawyer)

    params = {
      id: lawyer.id,
      lawyer: {
        password: "New password",
        activation_token: lawyer.activation_token,
      },
      password_confirmation: "A different password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Password and confirmation do not match.", flash[:error]
  end

  test 'PATCH update_password redirects back if token does not match' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    lawyer = users(:lawyer)

    params = {
      id: lawyer.id,
      lawyer: {
        password: "New password",
        activation_token: "bad token",
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Failed to update your password.", flash[:error]
  end

  test 'PATCH update_password redirects back if no token is provided' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    lawyer = users(:lawyer)
    lawyer.activation_token = nil
    lawyer.save

    params = {
      id: lawyer.id,
      lawyer: {
        password: "New password",
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Failed to update your password.", flash[:error]
  end
end
