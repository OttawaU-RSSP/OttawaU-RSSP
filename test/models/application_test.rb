require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "starts in intake state" do
    application = Application.new

    assert application.intake?
  end

  test "intaken transitions from intake to pending_follow_up" do
    application = Application.new
    application.intaken

    assert application.pending_follow_up?
  end

  test "follow_up transitions from pending_follow_up to followed_up" do
    application = Application.new(state: "pending_follow_up")
    application.follow_up

    assert application.followed_up?
  end

  test "accept_follow_up transitions from followed_up to in_progress if already matched with a lawyer" do
    application = Application.create(state: "followed_up")
    Assignee.create(application: application, user: users(:lawyer))

    application.accept_follow_up

    assert application.in_progress?
  end

  test "accept_follow_up transitions from followed_up to pending_lawyer_match if not matched with a lawyer" do
    application = Application.new(state: "followed_up")

    application.accept_follow_up

    assert application.pending_lawyer_match?
  end

  test "match_lawyer transitions from pending_lawyer_match to in_progress" do
    application = Application.new(state: "pending_lawyer_match")
    application.match_lawyer

    assert application.in_progress?
  end

  test "complete transitions from in_progress to completed" do
    application = Application.new(state: "in_progress")
    application.complete

    assert application.completed?
  end

  test "lawyer_review_complete transitions from completed to lawyer_reviewed" do
    application = Application.new(state: "completed")
    application.lawyer_review_complete

    assert application.lawyer_reviewed?
  end

  test "expert_review_complete transitions from lawyer_reviewed to expert_reviewed" do
    application = Application.new(state: "lawyer_reviewed")
    application.expert_review_complete

    assert application.expert_reviewed?
  end

  test "submit transitions from lawyer_reviewed to submitted" do
    application = Application.new(state: "lawyer_reviewed")
    application.submit

    assert application.submitted?
  end

  test "submit transitions from expert_reviewed to submitted" do
    application = Application.new(state: "expert_reviewed")
    application.submit

    assert application.submitted?
  end

  test "accept transitions from submitted to accepted" do
    application = Application.new(state: "submitted")
    application.accept

    assert application.accepted?
  end

  test "book_travel transitions from accepted to travel_booked" do
    application = Application.new(state: "accepted")
    application.book_travel

    assert application.travel_booked?
  end

  test "state must be valid" do
    application = Application.new(state: "invalid")

    refute application.valid?
  end

  test "reject marks application ineligible and notifies sponsor group" do
    application = applications(:in_progress)

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      application.reject
    end

    assert application.ineligible?
  end
end
