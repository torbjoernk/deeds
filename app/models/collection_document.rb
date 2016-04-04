class CollectionDocument < ActiveRecord::Base
  belongs_to :collection
  belongs_to :document

  validates :collection_id, uniqueness: { scope: :document_id }
end
