class CreateAttachedSeals < ActiveRecord::Migration
  def change
    create_table :attached_seals do |t|
      t.string :material
      t.string :attachment_type
      t.text :notes

      t.belongs_to :deed
      t.belongs_to :seal

      t.timestamps null: false
    end

    add_index :attached_seals, [:deed_id, :seal_id], unique: true
  end
end
