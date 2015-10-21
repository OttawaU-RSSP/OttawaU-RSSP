require 'test_helper'

class Admin::LawyersControllerTest < ActionController::TestCase
  attr_reader :admin

  setup do
    @admin = users(:admin)

    sign_in_as(@admin)
  end

  test "PUT #approve a given lawyer" do
    lawyer = users(:lawyer)
    lawyer.approved = false
    lawyer.save!
    lawyer.reload

    refute lawyer.approved?

    put :approve, id: lawyer.id

    lawyer.reload

    assert lawyer.approved?
    assert_redirected_to admin_lawyers_path
  end
end
