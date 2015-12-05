class AddPointToUser < ActiveRecord::Migration
  def change
    add_column :users, :point, :integer, default: 0
  end
end
