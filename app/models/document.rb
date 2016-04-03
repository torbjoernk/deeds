class Document < ActiveRecord::Base
  include IconicModel
  ICON = 'newspaper-o'

  DOCUMENT_TYPES = %w(original transcript print digital)

  belongs_to :deed, inverse_of: :documents

  has_many :collection_documents
  has_many :collections, through: :collection_documents

  validates :title, presence: true
  validates :title, uniqueness: { scope: :document_type }
  validates :document_type, presence: true
  validates :document_type, inclusion: DOCUMENT_TYPES
end
