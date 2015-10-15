require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "starts in intake state" do
    application = Application.new

    assert application.intake?
  end

  test "intaken transitions from intake to follow_up" do
    application = Application.new
    application.intaken

    assert application.follow_up?
  end

  test "accepted transitions from follow_up to accepted" do
    application = Application.new(state: "follow_up")
    application.accepted

    assert application.accepted?
  end

  test "processing transitions from accepted to in_progress" do
    application = Application.new(state: "accepted")
    application.processing

    assert application.in_progress?
  end

  test "reviewed transitions from in_progress to in_review" do
    application = Application.new(state: "in_progress")
    application.reviewed

    assert application.in_review?
  end

  test "submitted transitions from in_review to submitted" do
    application = Application.new(state: "in_review")
    application.submitted

    assert application.submitted?
  end

  test "approved transitions from submitted to approved" do
    application = Application.new(state: "submitted")
    application.approved

    assert application.approved?
  end

  test "state must be valid" do
    application = Application.new(state: "invalid")

    refute application.valid?
  end
end
