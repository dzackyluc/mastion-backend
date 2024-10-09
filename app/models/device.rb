class Device < ApplicationRecord
    belongs_to :user
    belongs_to :data_kandang
end