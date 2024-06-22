class CreateDataKelistrikan < ActiveRecord::Migration[7.1]
    def change
        create_table :data_kelistrikan do |t|
            t.string :data

            t.timestamps
        end
    end
end