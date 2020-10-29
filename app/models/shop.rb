class Shop < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :shop_name,    length: { maximum: 50 }, presence: true
  validates :shop_comment, length: { maximum: 500 }

  # mount_uploader :photo, ImageUploader
  has_many_attached :photos, dependent: :destroy

    # ショップ検索（曖昧）
    def Shop.search(search, user_or_list_or_shop)
      if user_or_list_or_shop == "3"
        Shop.where(['shop_name LIKE ?', "%#{search}%"])
      else
        Shop.all
      end
    end
end
