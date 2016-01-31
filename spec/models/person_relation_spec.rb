require 'rails_helper'

describe PersonRelation, type: :model do
  it 'does relate two People' do
    rel = create(:person_relation_one_two)

    expect(rel.person).to eq Person.find_by(attributes_for(:person_one))
    expect(rel.related).to eq Person.find_by(attributes_for(:person_two))
  end

  it 'does not save two equal relations' do
    rel = build(:person_relation_one_two)
    other = PersonRelation.new(person: rel.person, related: rel.related,
                               notes: 'another text')

    rel.save!

    expect { other.save! }.to raise_error ActiveRecord::RecordInvalid
  end
end
