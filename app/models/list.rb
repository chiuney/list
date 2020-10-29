class List < ApplicationRecord
  belongs_to :user
  has_many :shops, dependent: :destroy

  validates :list_name,    length: { in: 1..20 }
  validates :list_comment, length: { maximum: 500 } 

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
