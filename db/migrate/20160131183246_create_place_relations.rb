class CreatePlaceRelations < ActiveRecord::Migration
  def change
    create_table :place_relations do |t|
      t.belongs_to :place, index: true
      t.belongs_to :related, index: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
