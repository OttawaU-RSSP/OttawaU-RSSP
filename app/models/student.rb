class Student < User
  has_many :assignees, foreign_key: :user_id
  has_many :applications, through: :assignees

  store_accessor :extra, [
    :telephone,

    :city,
    :province,

    :university,
    :language,
    :course,
    :campus_group,

    :comments
  ]

  validates :telephone, :city, :province, :university, :language, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_format_of :telephone, with: /\A^[\+0-9\s\-\(\)]+$\z/

  def student?
    true
  end
end
