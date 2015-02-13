class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.date :birthday
      t.string :country
      t.string :city
      t.string :mobile

      t.integer :user_id

      t.timestamps
    end
  end
end
