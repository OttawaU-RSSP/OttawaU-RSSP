class SponsorGroupMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"
  ADMIN_EMAIL = "RefugeeSSP@uOttawa.ca"

  def intake_form_submitted(sponsor_group)
    @sponsor_group = sponsor_group

    @app_url = case Rails.env
    when "production"
      "http://ottawau-rssp.herokuapp.com/"
    else
      "https://myshopify.io"
    end

    mail(to: ADMIN_EMAIL, subject: "New sponsor group application")
  end
end
