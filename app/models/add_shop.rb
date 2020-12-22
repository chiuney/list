# frozen_string_literal: true

class AddShop < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  # shop_idとuser_idの組み合わせが複数できないように制限
  validates_uniqueness_of :shop_id, scope: :user_id
  validates :shop_id, presence: true
  validates :user_id, presence: true
end
