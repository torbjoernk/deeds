class PlaceRelation < ActiveRecord::Base
  RELATION_TYPES = %w(same side-by-side)

  belongs_to :place, class_name: 'Place'
  belongs_to :related, class_name: 'Place'

  validates :relation_type, inclusion: { in: RELATION_TYPES }
  validates_with NotSelfRelatedValidator
end
