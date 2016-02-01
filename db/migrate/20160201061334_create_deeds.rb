class CreateDeeds < ActiveRecord::Migration
  def change
    create_table :deeds do |t|
      t.string :title
      t.integer :year
      t.integer :month
      t.integer :day
      t.text :description
      t.text :notes

      t.timestamps null: false
    end

    add_index :deeds, [:title, :year, :month, :day], unique: true
  end
end
