class Deed < ActiveRecord::Base
  include IconicModel
  ICON = 'file-text-o'

  has_one :content
  has_many :translations, through: :content, foreign_key: :translation

  has_many :documents, inverse_of: :deed

  has_many :seals

  has_many :mention_entries, class_name: Mention::MentionEntry
  has_many :people, through: :mention_entries, class_name: 'Person'
  has_many :roles, through: :mention_entries, class_name: 'Role'
  has_many :places, through: :mention_entries, class_name: 'Place'

  has_and_belongs_to_many :references

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:year, :month, :day] }
  validates :year, numericality: { only_integer: true, allow_blank: true }
  validates :month, numericality: { only_integer: true, allow_blank: true,
                                    greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :day, numericality: { only_integer: true, allow_blank: true,
                                  greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }

  def mentioned_people
    people.group(:name).order(:name)
  end

  def mentioned_places
    places.group(:title).order(:title)
  end

  def mentioned_roles
    roles.group(:title).order(:title)
  end

  def to_s
    title
  end
end
