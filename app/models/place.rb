class Place < ActiveRecord::Base
  has_many :place_relations
  has_many :related, through: :place_relations

  def relatives
    Place.joins(:place_relations).where(place_relations: { related_id: self })
  end

  validates :title, uniqueness: true
  validates :title, presence: true
end
