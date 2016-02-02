class ContentTranslation < ActiveRecord::Base
  belongs_to :content
  has_one :deed, through: :content

  validates :translation, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: Content::LANGUAGES }
end
