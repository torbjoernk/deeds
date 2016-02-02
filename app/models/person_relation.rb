class PersonRelation < ActiveRecord::Base
  RELATION_TYPES = %w(same parent married child sibling)

  belongs_to :person, class_name: 'Person'
  belongs_to :related, class_name: 'Person'

  validates :relation_type, inclusion: { in: RELATION_TYPES }
  validates_with NotSelfRelatedValidator
end
