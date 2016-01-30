class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :source_type
      t.text :notes

      t.timestamps null: false
    end
  end
end
