class AddStatusColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :status, :string, default: 'pending'
  end
end
