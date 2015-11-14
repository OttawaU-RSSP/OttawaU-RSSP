require 'test_helper'

class Admin::AdminsControllerTest < ActionController::TestCase
  attr_reader :admin

  setup do
    @admin = users(:admin)

    sign_in_as(@admin)
  end

  test "GET index renders" do
    sign_in_as(users(:admin))

    get :index

    assert_response :ok
  end

  test "GET show renders" do
    get :show, id: @admin.id

    assert_response :ok
  end

  test "POST create makes an approved admin" do
    password = 'blabla'

    assert_difference 'Admin.count', +1 do
      post(:create, admin: {
        email: 'admin@test.com',
        name: 'Admin name'
      })
    end

    admin = Admin.last
    assert_equal 'admin@test.com', admin.email
    assert admin.approved
    assert_equal 'Admin name', admin.name
  end

  test "PATCH reactivate sends a reactivation email to admin" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      patch :reactivate, id: @admin.id
    end
  end

end
