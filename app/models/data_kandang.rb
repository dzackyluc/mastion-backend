class DataKandang < ApplicationRecord
  has_many :data_sapis
  has_many :devices
  belongs_to :user
end