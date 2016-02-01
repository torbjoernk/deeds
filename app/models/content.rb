class Content < ActiveRecord::Base
  LANGUAGES = %w(latin old_german contemporary_german)

  belongs_to :deed

  has_many :translations, class_name: 'ContentTranslation'

  validates :content, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: LANGUAGES }
end
