class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.integer :relation
      t.date :birthday
      t.integer :location

      t.timestamps null: false
    end
  end
end
