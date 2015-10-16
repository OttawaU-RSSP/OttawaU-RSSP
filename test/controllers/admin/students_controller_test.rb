require 'test_helper'

class Admin::StudentsControllerTest < ActionController::TestCase
  attr_reader :admin

  setup do
    @admin = users(:admin)

    sign_in_as(@admin)
  end

  test "PUT #approve a given student" do
    student = Student.create!(name: 'New Student', email: 'new@student.com', password: 'password')

    put :approve, id: student.id

    student.reload

    assert student.approved?
    assert_redirected_to admin_students_path
  end
end
