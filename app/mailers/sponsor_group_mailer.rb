class SponsorGroupMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"

  def intake_form_approved(sponsor_group)
    @sponsor_group = sponsor_group

    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP has accepted your intake form")
  end

  def follow_up_call_form_approved(sponsor_group)
    @sponsor_group = sponsor_group

    mail(to: @sponsor_group.email, subject: "OttawaU RefugeeSSP has accepted your follow up call")
  end

  def notify_ineligible(sponsor_group, reason)
    @sponsor_group = sponsor_group
    @reason = reason

    mail(to: @sponsor_group.email, subject: "Your application to OttawaU RefugeeSSP has been rejected #{reason}")
  end

end
