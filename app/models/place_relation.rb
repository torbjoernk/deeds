class PlaceRelation < ActiveRecord::Base
  belongs_to :place, class_name: 'Place'
  belongs_to :related, class_name: 'Place'

  validates :place_id, uniqueness: { scope: :related_id }
end
