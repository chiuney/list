# frozen_string_literal: true

class Shop < ApplicationRecord
  # googlemaps表示
  geocoded_by :shop_address

  # AddShop
  has_many :AddShop
  has_many :users, through: :AddShop

  has_many :list_shops, dependent: :destroy
  has_many :lists, through: :list_shops, dependent: :destroy
  accepts_nested_attributes_for :list_shops

  validates :shop_name, length: { maximum: 50 }, presence: true

  # ショップ検索（曖昧）
  def self.search(search, user_or_list_or_shop)
    if user_or_list_or_shop == '3'
      Shop.where(['shop_name LIKE ?', "%#{search}%"])
    else
      Shop.all
    end
  end

  # Active Storage 複数画像を投稿
  has_many_attached :photos

  # # Active Storage バリデーション
  # validate :photos_type

  # private

  # def photos_type
  #   if !photos.content_type.in?(%('photos/jpeg photos/jpg photos/png'))
  #     errors.add(:photos,'にはjpeg,jpg,pngファイルを使用してください')
  #   end
  # end
end
