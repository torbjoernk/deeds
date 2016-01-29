class ArchiveStorage < ActiveRecord::Base
  belongs_to :archive
  belongs_to :storage

  validates :archive_id, uniqueness: { scope: :storage_id }
end
