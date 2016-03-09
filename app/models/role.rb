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
end
