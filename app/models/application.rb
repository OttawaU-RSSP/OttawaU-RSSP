class Application < ActiveRecord::Base
  include AASM

  has_many :assignees
  has_many :users, through: :assignees

  aasm column: :state do
    state :intake, initial: true
    state :follow_up
    state :in_progress
    state :in_review
    state :submitted
    state :accepted

    event :intaken do
      transitions from: :intake, to: :follow_up
    end

    event :followed_up do
      transitions from: :follow_up, to: :in_progress
    end

    event :reviewed do
      transitions from: :in_progress, to: :in_review
    end

    event :submitted do
      transitions from: :in_review, to: :submitted
    end

    event :accepted do
      transitions from: :submitted, to: :accepted
    end
  end
end
