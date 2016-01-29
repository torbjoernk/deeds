class Archive < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, presence: true
  validates :abbr, uniqueness: true
end
