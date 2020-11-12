class ListShop < ApplicationRecord
  belongs_to :list, optional: true
  belongs_to :shop, optional: true
end
