class Person < ActiveRecord::Base
  include IconicModel
  ICON = 'user'

  GENDERS = %w(male female unknown)

  def self.icon_for_gender(gender)
    unless GENDERS.include? gender.to_s
      raise StandardError.new "Gender '#{gender.to_s}' invalid."
    end

    if gender.to_s == 'unknown'
      'question'
    else
      gender.to_s
    end
  end

  has_many :person_relations
  has_many :related, through: :person_relations

  has_many :mentions
  has_many :roles, through: :mentions, class_name: 'Role', source: :role
  has_many :places, through: :mentions, class_name: 'Place', source: :place
  has_many :deeds, through: :mentions, class_name: 'Deed', source: :deed

  before_save :default_values

  def default_values
    self.gender ||= 'unknown'
  end

  def relatives
    Person.joins(:person_relations).where(person_relations: { related_id: self })
  end

  def mentioned_deeds
    deeds.group(:title)
  end

  def mentioned_roles
    roles.group(:title)
  end

  def mentioned_places
    places.group(:title)
  end

  def to_s
    name
  end

  def gender_icon
    Person.icon_for_gender(gender)
  end

  validates :name, presence: true
  validates :name, uniqueness: { scope: :gender }
  validates :gender, inclusion: { in: GENDERS }
end
