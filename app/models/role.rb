class Role < ActiveRecord::Base
  include IconicModel
  ICON = 'graduation-cap'

  REFERS_TO = %w(person place deed)

  has_many :mention_entries, class_name: Mention::MentionEntry
  has_many :people, through: :mention_entries
  has_many :places, through: :mention_entries
  has_many :deeds, through: :mention_entries

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
