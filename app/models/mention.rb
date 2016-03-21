class Mention < ActiveRecord::Base
  include IconicModel
  ICON = 'exchange'

  belongs_to :deed
  belongs_to :person
  belongs_to :role
  belongs_to :place

  def to_s
    out = []
    out << "#{person.to_s}" unless person.nil?
    out << "as #{role.to_s}" unless role.nil?
    out << "of #{place.to_s}" unless place.nil?
    out << "in #{deed.to_s}" unless deed.nil?
    out.join(' ')
  end
end
