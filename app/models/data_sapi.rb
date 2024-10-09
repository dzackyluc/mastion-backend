class DataSapi < ApplicationRecord
    belongs_to :data_kandang
    has_many :data_pemeriksaans
end