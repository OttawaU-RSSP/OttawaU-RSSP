class AddPublicAndPrivateMeetingNotesToSponsorGroup < ActiveRecord::Migration
  def change
    add_column :sponsor_groups, :public_meeting_notes, :text
    add_column :sponsor_groups, :private_meeting_notes, :text
  end
end
