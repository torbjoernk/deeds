class Seal < ActiveRecord::Base
  include IconicModel
  ICON = 'bookmark-o'

  has_many :attached_seals
  has_many :deeds, through: :attached_seals

  validates :title, presence: true
end
