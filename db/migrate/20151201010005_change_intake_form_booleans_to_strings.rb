class ChangeIntakeFormBooleansToStrings < ActiveRecord::Migration
  def change
    change_column :sponsor_groups, :refugee_outside_country_of_origin, :string
    change_column :sponsor_groups, :sufficient_resources, :string
  end
end
