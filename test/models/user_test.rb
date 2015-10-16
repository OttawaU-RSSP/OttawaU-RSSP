require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "approve a user" do
    user = User.create!(name: 'New Lawyer', email: 'new@layer.com', password: 'password')
    user.approve

    assert user.approved?
  end
end
