class Micropost < ApplicationRecord
  belongs_to :user

  scope :recent_posts, ->{order(created_at: :desc)}

  validates :content, presence: true, length: {maximum: Settings.digit_140}
  validates :image, content_type: {
                      in: %w(image/jpeg image/gif image/png),
                      message: I18n.t("micropost.message.must_valid_image")
                    },
                    size: {
                      less_than: Settings.micropost.image_megabytes.megabytes,
                      message: I18n.t("micropost.message.less_than_5MB")
                    }

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: Settings.digit_500_500
  end
end
