class DataPemeriksaans < ActiveRecord::Migration[7.1]
  def change
    create_table :data_pemeriksaans do |t|
      t.string :suhu
      t.string :confidence
      t.string :sel_somatik
      t.references :data_sapi, null: false, foreign_key: true

      t.timestamps
    end
  end
end
