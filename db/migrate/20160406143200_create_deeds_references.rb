class CreateDeedsReferences < ActiveRecord::Migration
  def change
    create_table :deeds_references do |t|
      t.belongs_to :deed, index: true
      t.belongs_to :reference, index: true
    end
  end
end
