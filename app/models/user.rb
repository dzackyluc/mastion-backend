class User < ApplicationRecord
    has_secure_password

    has_one_attached :image

    has_many :data_kandangs

    after_commit :add_default_image, on: [:create]

    validates :username, presence: true, uniqueness: true

    private

    def add_default_image
        unless image.attached?
            image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.jpg')), filename: 'default.jpg', content_type: 'image/jpg')
        end
    end
end