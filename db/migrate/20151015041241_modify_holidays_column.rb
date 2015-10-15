class ModifyHolidaysColumn < ActiveRecord::Migration
  def change
    rename_column :holidays, :holiday_name, :name
    rename_column :holidays, :holiday_date, :date
  end
end
