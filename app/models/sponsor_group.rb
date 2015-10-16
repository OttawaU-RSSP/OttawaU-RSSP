class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = ["Canadian Citizen", "Permanent Resident", "Other"]

  has_one :application

  after_create :create_application, :notify_admin

  private

  def notify_admin
    AdminMailer.intake_form_submitted(self).deliver_now
  end
end
