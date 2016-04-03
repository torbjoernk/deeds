class Source < ActiveRecord::Base
  include IconicModel
  ICON = 'newspaper-o'

  SOURCE_TYPES = %w(original transcript print digital)

  belongs_to :deed, inverse_of: :sources

  has_many :collection_sources
  has_many :collections, through: :collection_sources

  validates :title, presence: true
  validates :title, uniqueness: { scope: :source_type }
  validates :source_type, presence: true
  validates :source_type, inclusion: SOURCE_TYPES
end
