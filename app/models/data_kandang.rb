class DataKandang < ApplicationRecord
  has_many :data_sapis :dependent => :destroy
  has_many :devices :dependent => :destroy
  belongs_to :user
end