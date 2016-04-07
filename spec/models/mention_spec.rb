require 'rails_helper'

describe MentionEntry, type: :model do
  let(:mention_entry) { build :mention_entry }

  it 'has a valid factory', use_db: true do
    mention_entry.save!
    expect(mention_entry).to be_valid
  end

  describe 'has attribute' do
    specify 'notes as string' do
      expect(mention_entry.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'one Deed', use_db: true do
      deed = build :deed

      mention_entry.deed = deed
      mention_entry.save!

      expect(mention_entry).to be_valid
      expect(mention_entry.deed).to eq deed
      expect(deed.mention_entries).to include mention_entry
    end

    specify 'one Person', use_db: true do
      person = build :person

      mention_entry.person = person
      mention_entry.save!

      expect(mention_entry).to be_valid
      expect(mention_entry.person).to eq person
      expect(person.mention_entries).to include mention_entry
    end

    specify 'one Place', use_db: true do
      place = build :place

      mention_entry.place = place
      mention_entry.save!

      expect(mention_entry).to be_valid
      expect(mention_entry.place).to eq place
      expect(place.mention_entries).to include mention_entry
    end

    specify 'one Role', use_db: true do
      role = build :role

      mention_entry.role = role
      mention_entry.save!

      expect(mention_entry).to be_valid
      expect(mention_entry.role).to eq role
      expect(role.mention_entries).to include mention_entry
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        mention_entry.notes = nil
        expect(mention_entry).to be_valid
      end
    end
  end
end
