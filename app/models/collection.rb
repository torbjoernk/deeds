class Collection < ActiveRecord::Base
  include IconicModel
  ICON = 'book'

  has_many :collection_storages
  has_many :storages, through: :collection_storages

  has_many :collection_documents
  has_many :documents, through: :collection_documents

  validates :title, uniqueness: true
  validates :title, presence: true
  validates :abbr, uniqueness: true
end
