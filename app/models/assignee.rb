class Assignee < ActiveRecord::Base
  belongs_to :application
  belongs_to :user

  validates :application, :user, presence: true
end
