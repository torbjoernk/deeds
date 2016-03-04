class ContentTranslation < ActiveRecord::Base
  include IconicModel
  ICON = 'language'

  belongs_to :content
  has_one :deed, through: :content

  validates :translation, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: Content::LANGUAGES }
end
