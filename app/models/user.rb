class User < ActiveRecord::Base
  include Clearance::User

  validates :name, presence: true

  def lawyer?
    false
  end

  def admin?
    false
  end

  def approve
    update_attribute(:approved, true)
  end
end
