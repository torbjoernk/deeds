class Person < ActiveRecord::Base
  GENDERS = %w(male female)

  has_many :person_relations
  has_many :related, through: :person_relations

  def relatives
    Person.joins(:person_relations).where(person_relations: { related_id: self })
  end

  validates :name, presence: true
  validates :name, uniqueness: { scope: :gender }
  validates :gender, inclusion: { in: GENDERS + [nil] }
end
