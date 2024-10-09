class CreateDataKandangs < ActiveRecord::Migration[7.1]
    def change
        create_table :data_kandangs do |t|
            t.string :nama_kandang
            t.integer :kapasitas
            t.text :description
            t.references :user, null: false, foreign_key: true

            t.timestamps
        end
    end
end