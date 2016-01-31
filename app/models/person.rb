class Person < ActiveRecord::Base
  GENDERS = %w(male female)

  validates :name, presence: true
  validates :name, uniqueness: { scope: :gender }
  validates :gender, inclusion: { in: GENDERS + [nil] }
end
