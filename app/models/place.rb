class Place < ActiveRecord::Base
  validates :title, uniqueness: true
  validates :title, presence: true
end
