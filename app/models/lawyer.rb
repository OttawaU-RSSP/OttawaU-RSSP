class Lawyer < User
  has_many :assignees, foreign_key: :user_id
  has_many :applications, through: :assignees

  EMPLOYMENT_TYPES = [
    'Court',
    'Government',
    'Law office',
    'Legal clinic',
    'Non-profit organization',
    'Union',
  ]

  attr_accessor :other_employment_type

  before_validation do
    other_employment_type.strip! unless other_employment_type.nil?
  end

  before_save do
    self.employment_type = other_employment_type if employment_type == "other"
  end

  PRACTICE_AREAS = [
    'Civil litigation',
    'Commercial',
    'Criminal',
    'Environment',
    'Family',
    'Immigration',
    'Labour/employment',
    'Real estate',
    'Refugee law',
    'Wills and estates',
  ]

  attr_accessor :other_area_of_practice

  before_validation do
    other_area_of_practice.strip! unless other_area_of_practice.nil?
  end

  before_save do
    self.areas_of_practice.map! do |area|
      if area == "other"
        other_area_of_practice
      else
        area
      end
    end
  end

  INTEREST_AREAS = [
    'Providing ongoing assistance to sponsors through SSP matching',
    'Providing one-time information and advice to sponsors at one-time meetings',
    'Public Legal Information Session'
  ]

  attr_accessor :language_interested_in_translating
  attr_accessor :other_area_of_interest

  before_validation do
    language_interested_in_translating.strip! unless language_interested_in_translating.nil?
    other_area_of_interest.strip! unless other_area_of_interest.nil?
  end

  before_save do
    areas_of_interest << language_interested_in_translating unless language_interested_in_translating.blank?
    areas_of_interest << other_area_of_interest unless other_area_of_interest.blank?
  end

  store_accessor :extra, [
    :address,
    :telephone,

    :employer_name,
    :employer_address,

    :employment_type,

    :practicing, # true/false
    :year_of_call, # YYYY
    :law_society, # (e.g. LSUC)
    :areas_of_practice, # Array of strings
    :experience_with_refugee_sponsorships, # yes/no
    :experience_with_refugee_sponsorships_clarification,
    :insurance, # Do you have insurance that will cover this activity? (Yes, no, unknown)
    :can_accomodate_meetings,
    :areas_of_interest, # Array of strings
    :comments
  ]

  validates :address, :telephone, :employer_name, :employer_address, :employment_type, :year_of_call, :law_society, :insurance, presence: true
  validates :other_area_of_practice, presence: true, if: ->(l) { l.areas_of_practice.include?("other") }
  validates :other_employment_type, presence: true, if: ->(l) { l.employment_type == "other" }
  validates :can_accomodate_meetings, :practicing, :experience_with_refugee_sponsorships, inclusion: [true, false]
  validates :year_of_call, format: { with: /\A\d\d\d\d\z/, message: 'should be formatted as YYYY (e.g. 1990)' }
  validates :experience_with_refugee_sponsorships_clarification, presence: true, if: ->(l) { l.experience_with_refugee_sponsorships }

  def areas_of_practice
    super || (self.areas_of_practice = [])
  end

  def areas_of_interest
    super || (self.areas_of_interest = [])
  end

  def practicing=(value)
    super(value == '1')
  end

  def experience_with_refugee_sponsorships=(value)
    super(value == '1')
  end

  def can_accomodate_meetings=(value)
    super(value == '1')
  end

  def lawyer?
    true
  end
end
