class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = ["Canadian Citizen", "Permanent Resident", "Other"]

  has_one :application

  validates :citizenship_status, inclusion: { in: CITIZENSHIP_STATUSES }
  validates :name, :email, :phone, presence: true
end
