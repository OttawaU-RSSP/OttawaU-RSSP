class User < ActiveRecord::Base
  include Clearance::User

  validates :name, :email, presence: true
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  store :extra, coder: JSON

  scope :not_assigned_to, ->(application) {
    where.not(id: application.assignees.select(:user_id))
  }

  scope :students, -> { where type: 'Student' }
  scope :lawyers, -> { where type: 'Lawyer' }
  scope :approved, -> { where approved: true }

  def lawyer?
    false
  end

  def admin?
    false
  end

  def student?
    false
  end

  def sponsor?
    false
  end

  def approve
    update_attribute(:approved, true)
  end
end
