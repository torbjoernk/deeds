class PersonRelation < ActiveRecord::Base
  RELATION_TYPES = %w(same parent married child sibling)

  belongs_to :person, class_name: 'Person'
  belongs_to :related, class_name: 'Person'

  validates :relation_type, inclusion: { in: RELATION_TYPES }
  validate :not_self_related

  def not_self_related
    if person_id != nil and related_id != nil and person_id == related_id
      errors.add(:self_related, 'can not relate a Person to its self')
    end
  end
end
