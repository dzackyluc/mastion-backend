class DataKandangSerializer < ActiveModel::Serializer
  attributes :id, :data, :created_at, :updated_at
end