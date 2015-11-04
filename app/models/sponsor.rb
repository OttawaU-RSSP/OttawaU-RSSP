class Sponsor < User
  belongs_to :sponsor_group

  store_accessor :extra, [
    :primary,
    :sponsor_group_id,
  ]

  def self.create_from_sponsor_group(sponsor_group)
    new_sponsor = new.tap do |sponsor|
      sponsor.name             = sponsor_group.name
      sponsor.email            = sponsor_group.email
      sponsor.password         = SecureRandom.hex(32)
      sponsor.approved         = true
      sponsor.primary          = true
      sponsor.sponsor_group_id = sponsor_group.id
    end

    new_sponsor.save!
    new_sponsor
  end

  def sponsor?
    true
  end
end
