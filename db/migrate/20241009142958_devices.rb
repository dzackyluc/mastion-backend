class Devices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.string :device_identifier
      t.string :device_name
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
