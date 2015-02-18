class AddWorkPlaceColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :work_place, :string
  end
end
