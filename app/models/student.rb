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

    :private_notes
  ]

  validates :telephone, :city, :province, :university, :language, presence: true
  validates :telephone, format: /\A^[\+0-9\s\-\(\)]+$\z/

  def student?
    true
  end

  def label
    "#{name} (#{applications.count})"
  end
end
