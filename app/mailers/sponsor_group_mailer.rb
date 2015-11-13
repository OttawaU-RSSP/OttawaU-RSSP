class SponsorGroupMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"

  def intake_received(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP has received your application")
  end

  def intake_form_approved(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP has accepted your intake form")
  end

  def follow_up_call_form_approved(primary_sponsor)
    @primary_sponsor = primary_sponsor
    @primary_sponsor.update_attributes!(activation_token: SecureRandom.urlsafe_base64)
    @activation_link = activate_session_url(token: @primary_sponsor.activation_token, only_path: false)

    mail(to: @primary_sponsor.email, subject: "OttawaU RefugeeSSP has accepted your follow up call")
  end

  def lawyer_review_passed(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP application has passed lawyer review")
  end

  def expert_review_passed(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP application has passed expert review")
  end

  def application_submitted(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP application has been submitted to the government of Canada")
  end

  def application_accepted(sponsor_group)
    @sponsor_group = sponsor_group
    mail(to: @sponsor_group.email, subject: "Congratulations! OttawaU RefugeeSSP application has been accepted by the Government of Canada")
  end

end
