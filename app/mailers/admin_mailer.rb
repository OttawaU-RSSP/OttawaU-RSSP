class AdminMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"
  ADMIN_EMAIL = "RefugeeSSP@uOttawa.ca"

  def intake_form_submitted(sponsor_group)
    @sponsor_group = sponsor_group
    @application_link =  admin_application_url(@sponsor_group.application, only_path: false)

    mail(to: ADMIN_EMAIL, subject: "New sponsor group application")
  end

  def student_application(student)
    @student = student
    @application_link = admin_user_url(@student, only_path: false)

    mail(to: ADMIN_EMAIL, subject: "New student application")
  end

  def lawyer_application(lawyer)
    @lawyer = lawyer
    @application_link = admin_user_url(@lawyer, only_path: false)

    mail(to: ADMIN_EMAIL, subject: "New lawyer application")
  end
end
