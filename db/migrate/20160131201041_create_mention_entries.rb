class CreateMentionEntries < ActiveRecord::Migration
  def change
    create_table :mention_entries do |t|
      t.belongs_to :deed
      t.belongs_to :person
      t.belongs_to :role
      t.belongs_to :place
      t.text :notes

      t.timestamps null: false
    end
  end
end
