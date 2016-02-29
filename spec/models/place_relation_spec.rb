require 'rails_helper'

describe PlaceRelation, type: :model do
  let(:place_relation) { build :place_relation }

  it 'has a valid factory', use_db: true do
    place_relation.save!
    expect(place_relation).to be_valid
  end

  describe 'has attribute' do
    specify 'relation_type as string' do
      expect(place_relation.relation_type).to be_a String
    end

    specify 'notes as text' do
      expect(place_relation.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'one Place' do
      place = build :place

      place_relation.place = place

      expect(place_relation).to be_valid
      expect(place_relation.place).to eq place
    end

    specify 'one related Place' do
      place = build :place

      place_relation.related = place

      expect(place_relation).to be_valid
      expect(place_relation.related).to eq place
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'relation_type' do
        place_relation.relation_type = nil
        expect(place_relation).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      describe 'association' do
        specify 'between two Places', use_db: true do
          place = build :place

          place_relation.place = place
          place_relation.save!

          place_relation.related = place
          expect(place_relation).not_to be_valid
        end
      end
    end

    describe 'value of' do
      describe 'relation_type' do
        specify "within #{PlaceRelation::RELATION_TYPES}" do
          PlaceRelation::RELATION_TYPES.each do |valid_rel_type|
            place_relation.relation_type = valid_rel_type
            expect(place_relation).to be_valid
          end

          place_relation.relation_type = 'not a relation type'
          expect(place_relation).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        place_relation.notes = nil
        expect(place_relation).to be_valid
      end
    end
  end
end
