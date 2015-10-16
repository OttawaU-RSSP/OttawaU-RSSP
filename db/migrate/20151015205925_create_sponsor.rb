class CreateSponsor < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name, null: false
      t.string :citizenship_status, null: false
      t.string :sponsor_type, null: false

      t.timestamps
    end
  end
end
