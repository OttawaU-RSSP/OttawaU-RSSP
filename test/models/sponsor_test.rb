require 'test_helper'

class SponsorTest < ActiveSupport::TestCase
  test "create_from_sponsor_group creates an approved sponsor with name and email of sponsor group" do
    sponsor_group = sponsor_groups(:one)

    sponsor = Sponsor.create_from_sponsor_group(sponsor_group)

    assert sponsor.approved?
    assert sponsor.primary
    assert_equal sponsor_group.email, sponsor.email
    assert_equal sponsor_group.name, sponsor.name
  end
end
