class AddPersonToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :person, index: true, foreign_key: true
  end
end
