class DataKandang < ApplicationRecord
  has_many :data_sapis
  belongs_to :user
end