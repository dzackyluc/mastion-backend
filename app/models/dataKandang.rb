class DataKandang < ApplicationRecord
  has_many :sapi
  belongs_to :user
end