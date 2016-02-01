class DeedFormat < ActiveRecord::Base
  MATERIALS = %w(parchment paper)

  belongs_to :deed

  validates :material, presence: true
  validates :material, inclusion: { in: MATERIALS }
  validates :width, numericality: { greater_than: 0.0, allow_blank: true }
  validates :height, numericality: { greater_than: 0.0, allow_blank: true }
end
