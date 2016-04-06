class Reference < ActiveRecord::Base
  include IconicModel
  ICON = 'external-link'

  MEDIUMS = %w(book sealbook deedbook periodical)

  has_and_belongs_to_many :deeds
  has_and_belongs_to_many :seals

  validates :title, presence: true
  validates :medium, inclusion: MEDIUMS, allow_blank: true

  def to_s
    out = []
    unless authors.nil? or authors.empty?
      out << authors
    end
    out << title
    unless medium.nil? or medium.empty?
      out << I18n.t(medium, scope: 'activerecord.attributes.reference.mediums')
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
