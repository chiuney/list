class ListShop < ApplicationRecord
  belongs_to :list
  belongs_to :shop
  
  validates :shop_id, uniqueness: { scope: :list_id }

  # Active Storage 複数画像を投稿
  has_many_attached :photos
end
