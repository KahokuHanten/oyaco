class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :holiday_name, :null => false
      t.date :holiday_date, :null => false

      t.timestamps null: false
    end
    add_index :holidays, :holiday_date, :unique => true
  end
end
