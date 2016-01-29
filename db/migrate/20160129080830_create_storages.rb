class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.string :title
      t.text :notes

      t.timestamps null: false
    end

    add_index :storages, :title, unique: true
  end
end
