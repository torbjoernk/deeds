class Role < ActiveRecord::Base
  include IconicModel
  ICON = 'graduation-cap'

  REFERS_TO = %w(person place deed)

  has_many :mentions
  has_many :people, through: :mentions
  has_many :places, through: :mentions
  has_many :deeds, through: :mentions

  validates :title, presence: true
  validates :referring, inclusion: { in: REFERS_TO }

  def mentioned_deeds
    deeds.group(:title)
  end

  def mentioned_places
    places.group(:title)
  end

  def mentioned_people
    people.group(:name)
  end

  def to_s
    title
  end
end
