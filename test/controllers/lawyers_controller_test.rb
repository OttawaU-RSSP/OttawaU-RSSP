require 'test_helper'

class LawyersControllerTest < ActionController::TestCase
  test 'GET #new renders' do
    get :new

    assert_response :ok
  end

  test 'POST create makes an unapproved lawyer with a random password' do
    password = 'blabla'

    assert_difference 'Lawyer.count', +1 do
      post(:create, lawyer: {
        email: 'bouke@test.nl',
        password: password,
        approved: true,
        name: 'Bouke van der Bijl',
        address: 'Netherlands 1',
        telephone: '0612123817',
        employer_name: 'Zijne Majesteit',
        employer_address: 'Oranjestraat 1',
        employment_type: 'Court',
        practicing: '1',
        year_of_call: '1900',
        law_society: 'LSUC',
        areas_of_practice: ['Environment'],
        experience_with_refugee_sponsorships: '0',
        experience_with_refugee_sponsorships_clarification: '',
        insurance: 'No',
        can_accomodate_meetings: '1',
        areas_of_interest: ['Providing ongoing assistance to sponsors through SSP matching'],
        comments: ''
      })
    end

    lawyer = Lawyer.last
    assert_equal 'bouke@test.nl', lawyer.email
    assert_not_equal password, lawyer.password
    refute lawyer.approved
    assert_equal 'Bouke van der Bijl', lawyer.name
  end
end
