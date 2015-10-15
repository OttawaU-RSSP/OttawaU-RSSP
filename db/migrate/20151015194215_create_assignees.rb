class CreateAssignees < ActiveRecord::Migration
  def change
    create_table :assignees do |t|
      t.references :application, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :primary, default: false, null: false

      t.timestamps null: false
    end
  end
end
