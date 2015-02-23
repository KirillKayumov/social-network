class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :sender_id
      t.integer :receiver_id
      t.string :status, default: 'sent', null: false

      t.timestamps
    end
  end
end
