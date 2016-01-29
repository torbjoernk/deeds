class Archive < ActiveRecord::Base
  has_many :archive_storages
  has_many :storages, through: :archive_storages

  validates :title, uniqueness: true
  validates :title, presence: true
  validates :abbr, uniqueness: true
end
