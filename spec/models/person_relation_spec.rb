require 'rails_helper'

describe PersonRelation, type: :model do
  let(:person_relation) { build :person_relation }

  it 'has a valid factory' do
    person_relation.save!
    expect(person_relation).to be_valid
  end

  describe 'has attribute' do
    specify 'relation_type as string' do
      expect(person_relation.relation_type).to be_a String
    end

    specify 'notes as text' do
      expect(person_relation.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'one Person' do
      person = build :person

      person_relation.person = person

      expect(person_relation).to be_valid
      expect(person_relation.person).to eq person
    end

    specify 'one related Person' do
      person = build :person

      person_relation.related = person

      expect(person_relation).to be_valid
      expect(person_relation.related).to eq person
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'relation_type' do
        person_relation.relation_type = nil
        expect(person_relation).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      describe 'association' do
        specify 'between two People' do
          person = build :person

          person_relation.person = person
          person_relation.save!

          person_relation.related = person
          expect(person_relation).not_to be_valid
        end
      end
    end

    describe 'value of' do
      describe 'relation_type' do
        specify "within #{PersonRelation::RELATION_TYPES}" do
          PersonRelation::RELATION_TYPES.each do |valid_rel_type|
            person_relation.relation_type = valid_rel_type
            expect(person_relation).to be_valid
          end

          person_relation.relation_type = 'not a relation type'
          expect(person_relation).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        person_relation.notes = nil
        expect(person_relation).to be_valid
      end
    end
  end
end
