class User < ActiveRecord::Base
  include Clearance::User

  validates :name, presence: true

  def lawyer?
    false
  end

  def admin?
    false
  end
end
