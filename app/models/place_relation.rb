class PlaceRelation < ActiveRecord::Base
  RELATION_TYPES = %w(same side-by-side)

  belongs_to :place, class_name: 'Place'
  belongs_to :related, class_name: 'Place'

  validates :relation_type, inclusion: { in: RELATION_TYPES }
  validate :not_self_related

  def not_self_related
    if place_id != nil and related_id != nil and place_id == related_id
      errors.add(:self_related, 'can not relate a Place to its self')
    end
  end
end
