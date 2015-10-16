class AdminMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"
  ADMIN_EMAIL = "RefugeeSSP@uOttawa.ca"

  def intake_form_submitted(sponsor_group)
    @sponsor_group = sponsor_group
    @app_url = app_url

    mail(to: ADMIN_EMAIL, subject: "New sponsor group application")
  end

  def student_application(student)
    @student = student
    @app_url = app_url

    mail(to: ADMIN_EMAIL, subject: "New student application")
  end

  def lawyer_application(lawyer)
    @lawyer = lawyer
    @app_url = app_url

    mail(to: ADMIN_EMAIL, subject: "New lawyer application")
  end

  private

  def app_url
    case Rails.env
    when "production"
      "http://ottawau-rssp.herokuapp.com/"
    else
      "https://myshopify.io"
    end
  end
end
