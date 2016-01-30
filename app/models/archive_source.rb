class ArchiveSource < ActiveRecord::Base
  belongs_to :archive
  belongs_to :source

  validates :archive_id, uniqueness: { scope: :source_id }
end
