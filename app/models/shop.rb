class Shop < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :favorite_list, optional: true

  validates :shop_name,    presence: true
  validates :shop_comment, presence: true
end
