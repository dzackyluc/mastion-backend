class CreateDataKandang < ActiveRecord::Migration[7.1]
    def change
        create_table :data_kandang do |t|
            t.string :nama_kandang
            t.integer :kapasitas
            t.integer :description

            t.timestamps
        end
    end
end