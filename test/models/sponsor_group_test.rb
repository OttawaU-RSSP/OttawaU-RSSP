require 'test_helper'

class SponsorGroupTest < ActiveSupport::TestCase
  test 'creating a sponsor group creates an associated application' do
    sponsor_group = create_sponsor
    assert_not_nil sponsor_group.application
  end

  test 'creating a sponsor group emails admin' do
    SponsorGroupMailer.expects(:intake_form_submitted).returns(stub(:deliver_now))

    create_sponsor
  end

  private

  def create_sponsor
    SponsorGroup.create(name: 'name', email: 'email', phone: 'phone')
  end
end
