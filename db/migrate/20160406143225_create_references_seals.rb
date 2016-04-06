class CreateReferencesSeals < ActiveRecord::Migration
  def change
    create_table :references_seals do |t|
      t.belongs_to :reference, index: true
      t.belongs_to :seal, index: true
    end
  end
end
