class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :gender, null: true
      t.text :notes

      t.timestamps null: false
    end

    add_index :people, [:name, :gender]
  end
end
