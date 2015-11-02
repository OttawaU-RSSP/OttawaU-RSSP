class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = ["Canadian Citizen", "Permanent Resident", "Other"]
  REFUGEE_CONNECTION_TYPES = ["Family", "Friends", "NGO", "Other"]

  has_one :application
end
