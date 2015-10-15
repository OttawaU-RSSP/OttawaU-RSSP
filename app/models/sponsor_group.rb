class SponsorGroup < ActiveRecord::Base
  has_one :application

  validates :citizenship_status, inclusion: { in: ["Canadian Citizen", "Permanent Resident", "Other"] }
  validates :name, :email, :phone, presence: true
end
