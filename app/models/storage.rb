class Storage < ActiveRecord::Base
  include IconicModel
  ICON = 'archive'

  has_many :archive_storages
  has_many :archives, through: :archive_storages

  validates :title, presence: true
  validates :title, uniqueness: true
end
