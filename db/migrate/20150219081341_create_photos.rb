class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :description
      t.integer :user_id
      t.string :image

      t.timestamps
    end
  end
end
