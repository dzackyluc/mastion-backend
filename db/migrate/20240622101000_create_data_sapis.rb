class CreateDataSapis < ActiveRecord::Migration[7.1]
    def change
      create_table :data_sapis do |t|
        t.string :bangsa
        t.string :jenis_kelamin
        t.string :bobot
        t.string :umur
        t.references :user, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end