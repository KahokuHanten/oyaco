class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :event, index: true, foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end
