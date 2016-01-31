class PersonRelation < ActiveRecord::Base
  belongs_to :person, class_name: 'Person'
  belongs_to :related, class_name: 'Person'

  validates :person_id, uniqueness: { scope: :related_id }
end
