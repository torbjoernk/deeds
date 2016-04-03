class CollectionStorage < ActiveRecord::Base
  belongs_to :collection
  belongs_to :storage

  validates :collection_id, uniqueness: { scope: :storage_id }
end
