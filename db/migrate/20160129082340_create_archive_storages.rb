class CreateArchiveStorages < ActiveRecord::Migration
  def change
    create_table :archive_storages do |t|
      t.belongs_to :archive
      t.belongs_to :storage

      t.timestamps null: false
    end

    add_index :archive_storages, [:archive_id, :storage_id], unique: true
  end
end
