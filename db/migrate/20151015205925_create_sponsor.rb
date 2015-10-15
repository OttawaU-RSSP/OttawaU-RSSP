class CreateSponsor < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :name
      t.string :citizenship_status
      t.string :sponsor_type

      t.timestamps
    end
  end
end
