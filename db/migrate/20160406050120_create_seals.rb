class CreateSeals < ActiveRecord::Migration
  def change
    create_table :seals do |t|
      t.string :title
      t.text :notes
      t.timestamps null: false
    end
  end
end
