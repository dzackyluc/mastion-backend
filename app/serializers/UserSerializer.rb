class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :username, :email, :phone_number, :bio, :image_url

  def image_url
    rails_blob_url(object.image, only_path: true) if object.image.attached?
  end
end