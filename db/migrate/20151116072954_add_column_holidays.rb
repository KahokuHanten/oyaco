class AddColumnHolidays < ActiveRecord::Migration
  def change
    add_column :holidays, :end_date, :date
  end
end
