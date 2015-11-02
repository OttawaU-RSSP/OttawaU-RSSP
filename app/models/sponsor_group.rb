class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = %w(Canadian\ Citizen Permanent\ Resident Other)
  REFUGEE_CONNECTION_TYPES = %w(Family Friends NGO Other)

  has_one :application
end
