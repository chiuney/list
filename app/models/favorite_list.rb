class FavoriteList < ApplicationRecord
  belongs_to :user

  validates :list_name,    presence: true
  validates :list_comment, presence: true
end
