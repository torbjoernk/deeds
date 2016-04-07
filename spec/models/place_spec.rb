require 'rails_helper'

describe Place, type: :model do
  let(:place) { build :place }

  it 'has a valid factory', use_db: true do
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
    let(:mention_entry1) { build :mention_entry }
    let(:mention_entry2) { build :mention_entry }

    specify 'many Places', use_db: true do
      other = create :place, title: Faker::Name.title
      place.place_relations << build(:place_relation, place: place, related: other)
      place.save!
      expect(place).to be_valid

      expect(place.related).to include other
    end

    specify 'many MentionEntries', use_db: true do
      place.mention_entries << mention_entry1
      place.mention_entries << mention_entry2
      place.save!

      expect(place).to be_valid
      expect(place.mention_entries).to include mention_entry1, mention_entry2
    end

    specify 'many mention_entryed People through MentionEntries', use_db: true do
      mention_entry1.person = build :person
      mention_entry2.person = build :person, name: Faker::Name.name

      place.mention_entries << mention_entry1
      place.mention_entries << mention_entry2
      place.save!

      expect(place).to be_valid
      expect(place.mention_entryed_people).to include mention_entry1.person, mention_entry2.person
    end

    specify 'many Roles through MentionEntries', use_db: true do
      mention_entry1.role = build :role
      mention_entry2.role = build :role, title: Faker::Name.title

      place.mention_entries << mention_entry1
      place.mention_entries << mention_entry2
      place.save!

      expect(place).to be_valid
      expect(place.roles).to include mention_entry1.role, mention_entry2.role
    end

    specify 'many Deeds through MentionEntries', use_db: true do
      deed = build :deed
      mention_entry1.deed = deed
      mention_entry2.deed = deed
      place.mention_entries << mention_entry1
      place.mention_entries << mention_entry2
      place.save!

      expect(place).to be_valid
      expect(place.deeds).to include mention_entry1.deed, mention_entry2.deed
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
      it 'is inverse of related Places', use_db: true do
        other = create :place, title: Faker::Name.title
        other.place_relations << build(:place_relation, place: other, related: place)

        expect(place.relatives).to include other
      end
    end
  end
end
