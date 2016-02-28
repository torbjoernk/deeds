require 'rails_helper'

describe Place, type: :model do
  let(:place) { build :place }

  it 'has a valid factory' do
    place.save!
    expect(place).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(place.title).to be_a String
    end

    specify 'notes as text' do
      expect(place.notes).to be_a String
    end
  end

  describe 'has association with' do
    let(:mention1) { build :mention }
    let(:mention2) { build :mention }

    specify 'many Places' do
      other = create :place, title: Faker::Name.title
      place.place_relations << build(:place_relation, place: place, related: other)
      place.save!
      expect(place).to be_valid

      expect(place.related).to include other
    end

    specify 'many Mentions' do
      place.mentions << mention1
      place.mentions << mention2
      place.save!

      expect(place).to be_valid
      expect(place.mentions).to include mention1, mention2
    end

    specify 'many mentioned People through Mentions' do
      mention1.person = build :person
      mention2.person = build :person, name: Faker::Name.name

      place.mentions << mention1
      place.mentions << mention2
      place.save!

      expect(place).to be_valid
      expect(place.mentioned_people).to include mention1.person, mention2.person
    end

    specify 'many Roles through Mentions' do
      mention1.role = build :role
      mention2.role = build :role, title: Faker::Name.title

      place.mentions << mention1
      place.mentions << mention2
      place.save!

      expect(place).to be_valid
      expect(place.roles).to include mention1.role, mention2.role
    end

    specify 'many Deeds through Mentions' do
      deed = build :deed
      mention1.deed = deed
      mention2.deed = deed
      place.mentions << mention1
      place.mentions << mention2
      place.save!

      expect(place).to be_valid
      expect(place.deeds).to include mention1.deed, mention2.deed
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        place.title = nil
        expect(place).not_to be_valid
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        place.notes = nil
        expect(place).to be_valid
      end
    end
  end

  describe 'methods' do
    describe '#relatives' do
      it 'is inverse of related Places' do
        other = create :place, title: Faker::Name.title
        other.place_relations << build(:place_relation, place: other, related: place)

        expect(place.relatives).to include other
      end
    end
  end
end
