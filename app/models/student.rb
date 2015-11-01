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

  def student?
    true
  end
end
