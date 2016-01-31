class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :content
      t.string :language
      t.text :notes

      t.timestamps null: false
    end
  end
end
