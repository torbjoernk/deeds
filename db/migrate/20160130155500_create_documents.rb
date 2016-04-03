class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :document_type
      t.text :notes
      t.belongs_to :deed, index: true

      t.timestamps null: false
    end
  end
end
