class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :state, null: false
      t.boolean :ineligible, default: false

      t.timestamps null: false
    end
  end
end
