class Deed < ActiveRecord::Base
  has_one :content
  has_many :translations, through: :content, foreign_key: :translation

  has_many :formats, class_name: 'DeedFormat'

  has_many :mentions
  has_many :people, through: :mentions, class_name: 'Person'
  has_many :roles, through: :mentions, class_name: 'Role'
  has_many :places, through: :mentions, class_name: 'Place'

  validates :title, presence: true
  validates :title, uniqueness: { scope: [:year, :month, :day] }
  validates :year, numericality: { only_integer: true, allow_blank: true }
  validates :month, numericality: { only_integer: true, allow_blank: true,
                                    greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :day, numericality: { only_integer: true, allow_blank: true,
                                  greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
end
