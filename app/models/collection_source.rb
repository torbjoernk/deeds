class CollectionSource < ActiveRecord::Base
  belongs_to :collection
  belongs_to :source

  validates :collection_id, uniqueness: { scope: :source_id }
end
