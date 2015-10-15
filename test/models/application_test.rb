require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "applications starts in intake state" do
    application = Application.new

    assert application.intake?
  end

  test "application intake_completed transitions from intake to follow_up" do
    application = Application.new
    application.intake_completed

    assert application.follow_up?
  end

  test "application follow_up_completed transitions from follow_up to in_progress" do
    application = Application.new(state: "follow_up")
    application.follow_up_completed

    assert application.in_progress?
  end

  test "application review transitions from in_progress to in_review" do
    application = Application.new(state: "in_progress")
    application.review

    assert application.in_review?
  end

  test "application submitted transitions from in_review to submitted" do
    application = Application.new(state: "in_review")
    application.submitted

    assert application.submitted?
  end

  test "application accepted transitions from submitted to accepted" do
    application = Application.new(state: "submitted")
    application.accepted

    assert application.accepted?
  end
end
