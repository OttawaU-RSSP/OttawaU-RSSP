class AddFollowUpCallAttributesToSponsorGroup < ActiveRecord::Migration
  def change
    add_column :sponsor_groups, :public_notes, :text
    add_column :sponsor_groups, :private_notes, :text
    add_column :sponsor_groups, :proper_group_size, :boolean
    add_column :sponsor_groups, :refugee_name, :string
    add_column :sponsor_groups, :refugee_nationality, :string
    add_column :sponsor_groups, :refugee_current_location, :string
    add_column :sponsor_groups, :connect_refugee_family_in_canada, :boolean
    add_column :sponsor_groups, :connect_refugee_no_family_in_canada, :boolean
  end
end
