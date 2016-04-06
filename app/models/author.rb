class Author < ActiveRecord::Base
  include IconicModel
  ICON = 'user-secret'

  validates :name, presence: true
end
