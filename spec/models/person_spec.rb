require 'rails_helper'

describe Person, type: :model do
  let(:person) { build :person }

  it 'has a valid factory', use_db: true do
    person.save!
    expect(person).to be_valid
  end

  describe 'has attribute' do
    specify 'name as string' do
      expect(person.name).to be_a String
    end

    specify 'gender as string' do
      expect(person.gender).to be_a String
    end

    specify 'notes as text' do
      expect(person.notes).to be_a String
    end
  end

  describe 'has association with' do
    let(:mention_entry1) { build :mention_entry }
    let(:mention_entry2) { build :mention_entry }

    specify 'many People', use_db: true do
      other = create :person, name: Faker::Name.name
      person.person_relations << build(:person_relation, person: person, related: other)
      person.save!
      expect(person).to be_valid

      expect(person.related).to include other
    end

    specify 'many MentionEntries', use_db: true do
      person.mention_entries << mention_entry1
      person.mention_entries << mention_entry2
      person.save!

      expect(person).to be_valid
      expect(person.mention_entries).to include mention_entry1, mention_entry2
    end

    specify 'many mention_entryed Places through MentionEntries', use_db: true do
      mention_entry1.place = build :place
      mention_entry2.place = build :place, title: Faker::Name.title

      person.mention_entries << mention_entry1
      person.mention_entries << mention_entry2
      person.save!

      expect(person).to be_valid
      expect(person.mention_entryed_places).to include mention_entry1.place, mention_entry2.place
    end

    specify 'many Roles through MentionEntries', use_db: true do
      mention_entry1.role = build :role
      mention_entry2.role = build :role, title: Faker::Name.title

      person.mention_entries << mention_entry1
      person.mention_entries << mention_entry2
      person.save!

      expect(person).to be_valid
      expect(person.roles).to include mention_entry1.role, mention_entry2.role
    end

    specify 'many Deeds through MentionEntries', use_db: true do
      deed = build :deed
      mention_entry1.deed = deed
      mention_entry2.deed = deed
      person.mention_entries << mention_entry1
      person.mention_entries << mention_entry2
      person.save!

      expect(person).to be_valid
      expect(person.deeds).to include mention_entry1.deed, mention_entry2.deed
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'name' do
        person.name = nil
        expect(person).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'name w.r.t. gender' do
        create :person

        expect(person).not_to be_valid

        person.name = Faker::Name.name
        expect(person).to be_valid
      end
    end

    describe 'value of' do
      describe 'gender' do
        specify "within #{Person::GENDERS}" do
          Person::GENDERS.each do |valid_gender|
            person.gender = valid_gender
            expect(person).to be_valid
          end

          person.gender = 'not a gender'
          expect(person).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'gender' do
        person.gender = nil
        expect(person).to be_valid
      end

      specify 'notes' do
        person.notes = nil
        expect(person).to be_valid
      end
    end
  end

  describe 'methods' do
    describe '#relatives' do
      it 'is inverse of related People', use_db: true do
        other = create :person, name: Faker::Name.name
        other.person_relations << build(:person_relation, person: other, related: person)

        expect(person.relatives).to include other
      end
    end
  end
end
