class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :phone_number
      t.string :image
      t.string :password_digest
      t.string :bio

      t.timestamps
    end
  end
end
