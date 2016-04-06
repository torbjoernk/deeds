class Seal < ActiveRecord::Base
  include IconicModel
  ICON = 'bookmark-o'
  MATERIALS = %w(wax)
  ATTACHMENT_TYPES = %w(silk hinging broken)

  belongs_to :deed

  validates :title, presence: true
  validates :material, inclusion: MATERIALS, allow_blank: true
  validates :attachment_type, inclusion: ATTACHMENT_TYPES, allow_blank: true
end
