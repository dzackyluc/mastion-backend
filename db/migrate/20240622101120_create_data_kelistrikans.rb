class CreateDataKelistrikans < ActiveRecord::Migration[7.1]
    def change
        create_table :data_kelistrikans do |t|
            t.string :data

            t.timestamps
        end
    end
end