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

  test 'PATCH update_password updates password, resets activation token, and signs in if password and confirmation match and token matches' do
    student = users(:student)

    params = {
      id: student.id,
      student: {
        password: "New password",
        activation_token: student.activation_token,
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to student_internal_root_path
    refute student.reload.activation_token == params[:student][:activation_token]
  end

  test 'PATCH update_password redirects back if password and confirmation do not match and token matches' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    student = users(:student)

    params = {
      id: student.id,
      student: {
        password: "New password",
        activation_token: student.activation_token,
      },
      password_confirmation: "A different password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Password and confirmation do not match.", flash[:error]
  end

  test 'PATCH update_password redirects back if token does not match' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    student = users(:student)

    params = {
      id: student.id,
      student: {
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

    student = users(:student)
    student.activation_token = nil
    student.save

    params = {
      id: student.id,
      student: {
        password: "New password",
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Failed to update your password.", flash[:error]
  end
end
