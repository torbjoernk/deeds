class Source < ActiveRecord::Base
  SOURCE_TYPES = %w(original transcript print digital)

  has_many :archive_sources
  has_many :archives, through: :archive_sources

  validates :title, presence: true
  validates :title, uniqueness: { scope: :source_type }
  validates :source_type, presence: true
  validates :source_type, inclusion: SOURCE_TYPES
end
