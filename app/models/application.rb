class Application < ActiveRecord::Base
  include AASM

  aasm column: :state do
    state :intake, initial: true
    state :accepted
    state :follow_up
    state :in_progress
    state :in_review
    state :submitted
    state :approved

    event :intaken do
      transitions from: :intake, to: :follow_up
    end

    event :accepted do
      transitions from: :follow_up, to: :accepted
    end

    event :processing do
      transitions from: :accepted, to: :in_progress
    end

    event :reviewed do
      transitions from: :in_progress, to: :in_review
    end

    event :submitted do
      transitions from: :in_review, to: :submitted
    end

    event :approved do
      transitions from: :submitted, to: :approved
    end
  end
end
