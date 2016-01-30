class Archive < ActiveRecord::Base
  has_many :archive_storages
  has_many :storages, through: :archive_storages

  has_many :archive_sources
  has_many :sources, through: :archive_sources

  validates :title, uniqueness: true
  validates :title, presence: true
  validates :abbr, uniqueness: true
end
