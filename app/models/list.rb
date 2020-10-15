class List < ApplicationRecord
  belongs_to :user
  has_many :shops, dependent: :destroy

  validates :list_name,    presence: true
  validates :list_comment, presence: true

  # リスト検索（曖昧）
  def List.search(search, user_or_list)
    if user_or_list == "2"
      List.where(['list_nameLIKE ?', "%#{search}%"])
    else
      List.all
    end
  end
end
