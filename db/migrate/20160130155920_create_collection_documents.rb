class CreateCollectionDocuments < ActiveRecord::Migration
  def change
    create_table :collection_documents do |t|
      t.belongs_to :collection
      t.belongs_to :document

      t.timestamps null: false
    end

    add_index :collection_documents, [:collection_id, :document_id], unique: true
  end
end
