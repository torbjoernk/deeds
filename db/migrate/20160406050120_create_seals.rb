class CreateSeals < ActiveRecord::Migration
  def change
    create_table :seals do |t|
      t.string :title
      t.string :material
      t.string :attachment_type
      t.text :notes
      t.belongs_to :deed, index: true

      t.timestamps null: false
    end
  end
end
