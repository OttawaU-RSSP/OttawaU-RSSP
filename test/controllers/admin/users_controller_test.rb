require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  attr_reader :user

  setup do
    @user = users(:admin)

    sign_in_as(@user)
  end

  test "PUT #approve a given user" do
    lawyer = Lawyer.create!(name: 'New Lawyer', email: 'new@layer.com', password: 'password')

    put :approve, id: lawyer.id

    lawyer.reload

    assert lawyer.approved?
    assert_redirected_to admin_users_path
  end
end
