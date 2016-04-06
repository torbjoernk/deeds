class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :title
      t.string :medium
      t.integer :year
      t.string :place
      t.string :authors
      t.text :notes

      t.timestamps null: false
    end
  end
end
