class ChangeUserExtraToHstore < ActiveRecord::Migration
  def change
    change_column :users, :extra, :hstore
  end
end
