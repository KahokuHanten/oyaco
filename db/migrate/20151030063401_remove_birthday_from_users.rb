class RemoveBirthdayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birthday_year, :integer
    remove_column :users, :birthday_month, :integer
    remove_column :users, :birthday_day, :integer
  end
end
