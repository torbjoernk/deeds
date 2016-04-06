class AttachedSeal < ActiveRecord::Base
  MATERIALS = %w(wax)
  ATTACHMENT_TYPES = %w(silk hinging broken)

  belongs_to :deed
  belongs_to :seal

  validates :deed_id, uniqueness: { scope: :seal_id }
  validates :material, inclusion: MATERIALS, allow_blank: true
  validates :attachment_type, inclusion: ATTACHMENT_TYPES, allow_blank: true
end
