class CreateSponsorGroup < ActiveRecord::Migration
  def change
    create_table :sponsor_groups do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :citizenship_status
      t.string :refugee_connection
      t.integer :group_size
      t.boolean :SAH_connection
      t.boolean :interpreter_needed
      t.boolean :sufficient_resources
      t.boolean :criminal_record
    end
  end
end
