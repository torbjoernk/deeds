class Content < ActiveRecord::Base
  LANGUAGES = %w(latin old_german)

  has_many :translations, class_name: 'ContentTranslation'

  validates :content, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: LANGUAGES }
end
