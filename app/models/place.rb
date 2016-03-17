class Place < ActiveRecord::Base
  include IconicModel
  ICON = 'map-marker'

  has_many :place_relations
  has_many :related, through: :place_relations

  has_many :mentions
  has_many :roles, through: :mentions, class_name: 'Role', source: :role
  has_many :people, through: :mentions, class_name: 'Person', source: :person
  has_many :deeds, through: :mentions, class_name: 'Deed', source: :deed

  def relatives
    Place.joins(:place_relations).where(place_relations: { related_id: self })
  end

  def mentioned_deeds
    deeds.group(:title)
  end

  def mentioned_roles
    roles.group(:title)
  end

  def mentioned_people
    people.group(:name)
  end

  def to_s
    title
  end

  validates :title, uniqueness: true
  validates :title, presence: true
end
