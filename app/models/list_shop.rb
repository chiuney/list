rails g rspec:modelclass ListShop < ApplicationRecord
  belongs_to :list
  belongs_to :shop

  validates :shop_id, uniqueness: { scope: :list_id }
end
