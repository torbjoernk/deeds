class CreateCollectionStorages < ActiveRecord::Migration
  def change
    create_table :collection_storages do |t|
      t.belongs_to :collection
      t.belongs_to :storage

      t.timestamps null: false
    end

    add_index :collection_storages, [:collection_id, :storage_id], unique: true
  end
end
