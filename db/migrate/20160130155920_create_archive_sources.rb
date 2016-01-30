class CreateArchiveSources < ActiveRecord::Migration
  def change
    create_table :archive_sources, id: false do |t|
      t.belongs_to :archive, index: true
      t.belongs_to :source, index: true

      t.timestamps null: false
    end
  end
end
