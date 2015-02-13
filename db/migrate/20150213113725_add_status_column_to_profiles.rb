class AddStatusColumnToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :status, :string, default: ProfileDecorator::STATUSES.first
  end
end
