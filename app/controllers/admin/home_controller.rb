class Admin::HomeController < ApplicationController
  def index
    @applications = Application.all
    @unapproved_student_count = Student.where(approved: false).count
    @unapproved_lawyer_count  = Lawyer.where(approved: false).count
  end
end
