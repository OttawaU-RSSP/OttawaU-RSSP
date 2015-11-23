class DropConnectWithRefugeeNoFamilyInCanadaFromSponsorGroup < ActiveRecord::Migration
  def change
    remove_column :sponsor_groups, :connect_refugee_no_family_in_canada, :boolean
    add_column :sponsor_groups, :add_to_refugee_assistance_list, :boolean, default: false, null: false
  end
end
