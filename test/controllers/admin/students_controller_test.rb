require 'test_helper'

class Admin::StudentsControllerTest < ActionController::TestCase
  attr_reader :admin

  setup do
    @admin = users(:admin)

    sign_in_as(@admin)
  end

  test "PUT #approve a given student" do
    student = users(:student)
    student.approved = false
    student.save!

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :approve, id: student.id
    end

    student.reload

    assert student.approved?
    assert_redirected_to admin_students_path
  end

  test "PUT #add_private_notes adds private_notes to a given student" do
    student = users(:student)
    student.private_notes = ""
    student.save!

    request.env["HTTP_REFERER"] = "http://test.host/admin/students/#{student.id}"

    put :add_private_notes, id: student.id, student: { private_notes: "New comment" }

    student.reload

    assert_equal "New comment", student.private_notes
    assert_equal "Your comment has been added", flash[:notice]
    assert_redirected_to :back
  end

  test "DELETE #destroy destroys a given student" do
    student = users(:student)

    assert_difference 'Student.count', -1 do
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do
        delete :destroy, id: student.id
      end
    end
  end
end
