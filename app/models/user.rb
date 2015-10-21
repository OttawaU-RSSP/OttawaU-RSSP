class User < ActiveRecord::Base
  include Clearance::User

  validates :name, presence: true
  store :extra, coder: JSON

  scope :not_assigned_to, ->(application) {
    where.not(id: application.assignees.select(:user_id))
  }

  scope :students, -> { where type: 'Student' }
  scope :lawyers, -> { where type: 'Lawyer' }

  def lawyer?
    false
  end

  def admin?
    false
  end

  def approve
    update_attribute(:approved, true)
  end

  def student?
    false
  end
end
