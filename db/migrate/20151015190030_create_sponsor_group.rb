class CreateSponsorGroup < ActiveRecord::Migration
  def change
    create_table :sponsor_groups do |t|
      t.string :name null: false
      t.string :phone null: false
      t.string :email null: false
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :postal_code
      t.string :citizenship_status

      t.boolean :connected_to_refugee
      t.string :refugee_connection_type
      t.boolean :refugee_outside_country_of_origin

      t.integer :group_size
      t.boolean :sah_connection
      t.boolean :interpreter_needed
      t.boolean :sufficient_resources
      t.boolean :criminal_record

      t.timestamps
    end
  end
end
