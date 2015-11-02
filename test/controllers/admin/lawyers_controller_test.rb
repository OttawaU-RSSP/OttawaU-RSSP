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

  test "PUT #add_private_notes adds private_notes to a given lawyer" do
    lawyer = users(:lawyer)
    lawyer.private_notes = ""
    lawyer.save!

    request.env["HTTP_REFERER"] = "http://test.host/admin/lawyers/#{lawyer.id}"

    put :add_private_notes, id: lawyer.id, lawyer: { private_notes: "New comment" }

    lawyer.reload

    assert_equal "New comment", lawyer.private_notes
    assert_equal "Your comment has been added", flash[:notice]
    assert_redirected_to :back
  end
end
