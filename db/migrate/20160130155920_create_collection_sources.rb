class CreateCollectionSources < ActiveRecord::Migration
  def change
    create_table :collection_sources do |t|
      t.belongs_to :collection
      t.belongs_to :source

      t.timestamps null: false
    end

    add_index :collection_sources, [:collection_id, :source_id], unique: true
  end
end
