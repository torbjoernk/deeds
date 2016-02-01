class CreateContentTranslations < ActiveRecord::Migration
  def change
    create_table :content_translations do |t|
      t.belongs_to :content
      t.text :translation
      t.string :language
      t.text :notes

      t.timestamps null: false
    end
  end
end
