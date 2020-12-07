class List < ApplicationRecord
  belongs_to :user
  has_many :list_shops, dependent: :destroy
  has_many :shops, dependent: :destroy, through: :list_shops

  validates :list_name,    length: { maximum: 50 }, presence: true
  validates :list_comment, length: { maximum: 500 }
  validates :user_id,      presence: true

  has_many_attached :photos

  # リスト検索（曖昧）
  def List.search(search, user_or_list_or_shop)
    if user_or_list_or_shop == "2"
      List.where(['list_name LIKE ?', "%#{search}%"])
    else
      List.all
    end
  end
end
