class AddProvinceToSponsorGroup < ActiveRecord::Migration
  def change
    add_column :sponsor_groups, :province, :string
  end
end
