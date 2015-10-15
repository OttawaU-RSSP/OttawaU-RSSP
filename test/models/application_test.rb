require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "applications starts in intake state" do
    application = Application.new

    assert application.intake?
  end
end
