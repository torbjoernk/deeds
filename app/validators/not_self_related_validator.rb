class NotSelfRelatedValidator < ActiveModel::Validator
  def validate(record)
    raise 'Only for PersonRelation or PlaceRelation' unless record.is_a? PersonRelation or record.is_a? PlaceRelation

    if record.is_a? PersonRelation
      obj_id = record.person_id
      obj = Person
    else # record.is_a? PlaceRelation
      obj_id = record.place_id
      obj = Place
    end

    if obj_id != nil and obj_id == record.related_id
      record.errors.add(:self_related, "can not relate a #{obj.name} to its self")
    end
  end
end