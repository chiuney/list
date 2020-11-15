class ListShop < ApplicationRecord
  belongs_to :list
  belongs_to :shop
  
  validates :shop_id, uniqueness: true
end
