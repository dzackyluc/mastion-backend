class Streams < ActiveRecord::Migration[7.1]
  def change
    create_table :streams do |t|
      t.string :stream_key
      t.string :stream_url

      t.timestamps
    end
  end
end
