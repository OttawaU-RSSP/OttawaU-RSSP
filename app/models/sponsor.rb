class Sponsor < User
  belongs_to :sponsor_group

  validates :name, presence: true
  validates :citizenship_status, inclusion: { in: ["Canadian Citizen", "Permanent Resident", "Other"] }
  validates :sponsor_type, inclusion: { in: ["Primary", "Secondary", "Default"] }
end
