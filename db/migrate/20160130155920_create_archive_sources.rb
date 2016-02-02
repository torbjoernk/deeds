class CreateArchiveSources < ActiveRecord::Migration
  def change
    create_table :archive_sources do |t|
      t.belongs_to :archive
      t.belongs_to :source

      t.timestamps null: false
    end

    add_index :archive_sources, [:archive_id, :source_id], unique: true
  end
end
