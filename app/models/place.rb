class Place < ActiveRecord::Base
  has_many :place_relations
  has_many :related, through: :place_relations

  has_many :mentions
  has_many :roles, through: :mentions, class_name: 'Role', source: :role
  has_many :mentioned_people, through: :mentions, class_name: 'Person', source: :person
  has_many :deeds, through: :mentions, class_name: 'Deed', source: :deed

  def relatives
    Place.joins(:place_relations).where(place_relations: { related_id: self })
  end

  validates :title, uniqueness: true
  validates :title, presence: true
end
