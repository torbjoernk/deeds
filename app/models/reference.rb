class Reference < ActiveRecord::Base
  include IconicModel
  ICON = 'external-link'

  has_and_belongs_to_many :deeds
  has_and_belongs_to_many :seals

  validates :title, presence: true

  def to_s
    out = []
    unless authors.nil? or authors.empty?
      out << authors
    end
    out << title
    unless container.nil? or container.empty?
      out << "#{I18n.t('views.reference.container_prefix')} #{container}"
    end
    unless place.nil? or place.empty?
      out << place
    end
    unless year.nil?
      out << year.to_s
    end
    out.join(', ')
  end
end
