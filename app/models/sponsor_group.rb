class SponsorGroup < ActiveRecord::Base
  CITIZENSHIP_STATUSES = %w(Canadian\ Citizen Permanent\ Resident Other)
  REFUGEE_CONNECTION_TYPES = %w(Family Friends NGO Other N/A)
  BOOLEAN_LIKE_CHOICES = %w(Yes No Unknown N/A)

  has_one :application, dependent: :destroy
  has_many :sponsors

  def primary_sponsor
    sponsors.where(primary: true).first
  end
end
