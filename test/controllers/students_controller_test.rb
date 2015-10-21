require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  test 'GET #new renders' do
    get :new

    assert_response :ok
  end

  test 'POST create makes an unapproved student with a random password' do
    password = 'blabla'

    assert_difference 'Student.count', +1 do
      post(:create, student: {
        email: 'bouke@test.nl',
        password: password,
        approved: true,
        name: 'Bouke van der Bijl',
        telephone: '0612123817',
        city: 'Amsterdam',
        province: 'North Holland',
        university: 'University of Amsterdam',
        language: 'Dutch',
      })
    end

    student = Student.last
    assert_equal 'bouke@test.nl', student.email
    assert_not_equal password, student.password
    refute student.approved
    assert_equal 'Bouke van der Bijl', student.name
  end
end
