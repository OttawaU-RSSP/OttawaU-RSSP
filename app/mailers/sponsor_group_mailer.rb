class AdminMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"

  def intake_form_approved(sponsor_group)
    @sponsor_group = sponsor_group
  end

  def notify_ineligible(sponsor_group, reason)
    @sponsor_group = sponsor_group
    @reason = reason
  end

end
