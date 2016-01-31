class CreatePersonRelations < ActiveRecord::Migration
  def change
    create_table :person_relations do |t|
      t.belongs_to :person, index: true
      t.belongs_to :related, index: true
      t.string :type
      t.text :notes

      t.timestamps null: false
    end
  end
end
