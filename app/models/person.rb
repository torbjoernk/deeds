class Person < ActiveRecord::Base
  GENDERS = %w(male female)

  has_many :person_relations
  has_many :related, through: :person_relations

  has_many :mentions
  has_many :roles, through: :mentions, class_name: 'Role', source: :role
  has_many :mentioned_places, through: :mentions, class_name: 'Place', source: :place
  has_many :deeds, through: :mentions, class_name: 'Deed', source: :deed

  def relatives
    Person.joins(:person_relations).where(person_relations: { related_id: self })
  end

  validates :name, presence: true
  validates :name, uniqueness: { scope: :gender }
  validates :gender, inclusion: { in: GENDERS + [nil] }
end
