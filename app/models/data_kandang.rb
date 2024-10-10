class DataKandang < ApplicationRecord
  has_many :data_sapis, dependent: :destroy
  belongs_to :user
end