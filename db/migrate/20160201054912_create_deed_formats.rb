class CreateDeedFormats < ActiveRecord::Migration
  def change
    create_table :deed_formats do |t|
      t.belongs_to :deed
      t.string :material
      t.float :width
      t.float :height

      t.timestamps null: false
    end
  end
end
