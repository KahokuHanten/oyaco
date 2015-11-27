class CreateEvents2 < ActiveRecord::Migration
  def change
    create_table :events, force: true do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
