class Application < ActiveRecord::Base
  include AASM

  aasm column: :state do
    state :intake, initial: true
    state :completed_intake
    state :follow_up
    state :in_review
    state :accepted
  end
end
