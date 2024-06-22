class CreateDataKandangs < ActiveRecord::Migration[7.1]
    def change
        create_table :data_kandangs do |t|
            t.string :nama_kandang
            t.integer :kapasitas
            t.integer :description
            t.references :user, null: false, foreign_key: true
            t.references :data_sapi, null: false, foreign_key: true

            t.timestamps
        end
    end
end