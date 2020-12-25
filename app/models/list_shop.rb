# frozen_string_literal: true

class ListShop < ApplicationRecord
  belongs_to :list
  belongs_to :shop

  validates :shop_id, uniqueness: { scope: :list_id }, presence: true
  validates :list_id, presence: true


  def upload_photos
    # photosの登録
    # 詳細→https://api.rubyonrails.org/classes/ActiveStorage/Blob.html#method-c-generate_unique_secure_token
    new_photos = params[:photos].map do |photo|
      ActiveStorage::Blob.create_and_upload! \
        io: photo.open,
        filename: photo.original_filename,
        content_type: photo.content_type
    end
    photos.attach(new_photos)
    update!(id: params[:shop_id])
  end



  # Active Storage バリデーション
  # validate :content_type

  # private

  # def content_type
  #   if !photos.content_type.in?(%('photos/jpeg photos/jpg photos/png'))
  #     errors.add(:photos,'にはjpeg,jpg,pngファイルを使用してください')
  #   end
  # end
end
