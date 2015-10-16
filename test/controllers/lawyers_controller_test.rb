require 'test_helper'

class LawyersControllerTest < ActionController::TestCase
  test 'GET #new renders' do
    get :new

    assert_response :ok
  end

  test 'POST create makes an unapproved lawyer with a random password' do
    password = 'blabla'
    post :create, lawyer: { email: 'bouke@test.nl', password: password, approved: true, name: 'Bouke van der Bijl' }

    lawyer = Lawyer.last
    assert_equal lawyer.email, 'bouke@test.nl'
    assert_not_equal lawyer.password, password
    refute lawyer.approved
    assert_equal lawyer.name, 'Bouke van der Bijl'
  end
end
