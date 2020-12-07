class ListShop < ApplicationRecord
  belongs_to :list
  belongs_to :shop

  validates :shop_id, uniqueness: { scope: :list_id },presence: true
  validates :list_id, presence: true
end
