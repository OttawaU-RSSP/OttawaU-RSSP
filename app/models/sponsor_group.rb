class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = ["Canadian Citizen", "Permanent Resident", "Other"]

  has_one :application
end
