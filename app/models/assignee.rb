class Assignee < ActiveRecord::Base
  belongs_to :application
  belongs_to :user

  validates :application, :user, presence: true
  validates :user, uniqueness: { scope: [:application_id] }
end
