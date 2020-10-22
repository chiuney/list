class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :shop_name,    presence: true
  validates :shop_comment, presence: true

  mount_uploader :photo, ImageUploader
end
