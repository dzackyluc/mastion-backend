class DataPemeriksaan < ApplicationRecord
  belongs_to :data_sapi
  belongs_to :data_kandang
end