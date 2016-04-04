class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :title
      t.string :abbr
      t.text :notes

      t.timestamps null: false
    end

    add_index :collections, :title, unique: true
    add_index :collections, :abbr, unique: true
  end
end
