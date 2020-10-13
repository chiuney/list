class List < ApplicationRecord
  belongs_to :user
  has_many :shops, dependent: :destroy

  validates :list_name,    presence: true
  validates :list_comment, presence: true
end
