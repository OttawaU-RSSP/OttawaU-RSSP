class Lawyer < User
  has_many :assignees, foreign_key: :user_id
  has_many :applications, through: :assignees

  def lawyer?
    true
  end
end
