class ContentTranslation < ActiveRecord::Base
  belongs_to :content

  validates :translation, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: Content::LANGUAGES }
  validates :content_id, presence: true
end
