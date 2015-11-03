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

  def account_created(admin)
    @admin = admin
    @admin.update_attributes(activation_token: SecureRandom.urlsafe_base64)
    @activation_link = activate_session_url(token: @admin.activation_token, only_path: false)

    mail(to: admin.email, subject: "An admin account has been created for you on RefugeeSSP")
  end
end
