class Application < ActiveRecord::Base
  include AASM

  has_many :assignees
  has_many :users, through: :assignees
  belongs_to :sponsor_group

  aasm column: :state do
    state :intake, initial: true
    state :pending_follow_up
    state :followed_up
    state :pending_lawyer_match
    state :in_progress
    state :completed
    state :lawyer_reviewed
    state :expert_reviewed
    state :submitted
    state :accepted
    state :travel_booked

    event :intaken do
      transitions from: :intake, to: :pending_follow_up
    end

    event :follow_up do
      transitions from: :pending_follow_up, to: :followed_up
    end

    event :accept_follow_up do
      transitions from: :followed_up, to: :in_progress, if: :lawyer_assigned?
      transitions from: :followed_up, to: :pending_lawyer_match, unless: :lawyer_assigned?
    end

    event :match_lawyer do
      transitions from: :pending_lawyer_match, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :lawyer_review_complete do
      transitions from: :completed, to: :lawyer_reviewed
    end

    event :expert_review_complete do
      transitions from: :lawyer_reviewed, to: :expert_reviewed
    end

    event :submit do
      transitions from: [:lawyer_reviewed, :expert_reviewed], to: :submitted
    end

    event :accept do
      transitions from: :submitted, to: :accepted
    end

    event :book_travel do
      transitions from: :accepted, to: :travel_booked
    end
  end

  def lawyer
    users.lawyers.first
  end

  def students
    users.students
  end

  def reject
    update_attributes(ineligible: true)
    notify_rejected
  end

  private

  def notify_rejected
    SponsorGroupMailer.notify_ineligible(sponsor_group, "Reason").deliver_now
  end

  def lawyer_assigned?
    lawyer.present?
  end
end
