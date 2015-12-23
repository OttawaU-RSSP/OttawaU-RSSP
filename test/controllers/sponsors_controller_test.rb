require 'test_helper'

class SponsorsControllerTest < ActionController::TestCase
  test 'GET #show renders for logged in sponsor' do
    sponsor = users(:sponsor)
    sponsor.sponsor_group_id = sponsor_groups(:one).id
    sponsor.save

    sign_in_as(sponsor)

    get :show, id: sponsor.id

    assert_response :ok
  end

  test 'GET #show does not render for not logged in sponsor' do
    sponsor = users(:sponsor)
    sponsor.sponsor_group_id = sponsor_groups(:one).id
    sponsor.save

    get :show, id: sponsor.id

    assert_redirected_to new_session_path
  end

  test 'PATCH update_password updates password, resets activation token, and signs in if password and confirmation match and token matches' do
    sponsor = users(:sponsor)

    params = {
      id: sponsor.id,
      sponsor: {
        password: "New password",
        activation_token: sponsor.activation_token,
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to sponsor_path(sponsor)
    refute sponsor.reload.activation_token == params[:sponsor][:activation_token]
  end

  test 'PATCH update_password redirects back if password and confirmation do not match and token matches' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    sponsor = users(:sponsor)

    params = {
      id: sponsor.id,
      sponsor: {
        password: "New password",
        activation_token: sponsor.activation_token,
      },
      password_confirmation: "A different password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Password and confirmation do not match.", flash[:error]
  end

  test 'PATCH update_password redirects back if token does not match' do
    request.env["HTTP_REFERER"] = "http://test.host/sessions/activate"

    sponsor = users(:sponsor)

    params = {
      id: sponsor.id,
      sponsor: {
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

    sponsor = users(:sponsor)
    sponsor.activation_token = nil
    sponsor.save

    params = {
      id: sponsor.id,
      sponsor: {
        password: "New password",
      },
      password_confirmation: "New password"
    }

    patch(:update_password, params)

    assert_redirected_to :back
    assert_equal "Failed to update your password.", flash[:error]
  end
end
