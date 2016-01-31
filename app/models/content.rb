class Content < ActiveRecord::Base
  LANGUAGES = %w(latin old_german)

  validates :content, presence: true
  validates :language, presence: true
  validates :language, inclusion: { in: LANGUAGES }
end
