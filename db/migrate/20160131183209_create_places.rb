class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :title
      t.text :notes

      t.timestamps null: false
    end
  end
end
