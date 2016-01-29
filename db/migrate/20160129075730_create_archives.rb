class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.string :title
      t.string :abbr
      t.text :notes

      t.timestamps null: false
    end

    add_index :archives, :title, unique: true
    add_index :archives, :abbr, unique: true
  end
end
