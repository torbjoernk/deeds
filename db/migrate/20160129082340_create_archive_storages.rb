class CreateArchiveStorages < ActiveRecord::Migration
  def change
    create_table :archive_storages, id: false do |t|
      t.belongs_to :archive, index: true
      t.belongs_to :storage, index: true

      t.timestamps null: false
    end
  end
end
