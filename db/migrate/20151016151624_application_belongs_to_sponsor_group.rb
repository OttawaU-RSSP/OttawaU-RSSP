class ApplicationBelongsToSponsorGroup < ActiveRecord::Migration
  def change
    add_reference :applications, :sponsor_group, index: true
  end
end
