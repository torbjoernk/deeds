class Storage < ActiveRecord::Base
  include IconicModel
  ICON = 'archive'

  has_many :collection_storages
  has_many :collections, through: :collection_storages

  validates :title, presence: true
  validates :title, uniqueness: true
end
