require 'rails_helper'

describe Role, type: :model do
  let(:role) { build :role }

  it 'has a valid factory', use_db: true do
    role.save!
    expect(role).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(role.title).to be_a String
    end

    specify 'referring as string' do
      expect(role.referring).to be_a String
    end

    specify 'notes as text' do
      expect(role.notes).to be_a String
    end
  end

  context 'has association with', use_db: true do
    let(:mention_entry1) { build :mention_entry }
    let(:mention_entry2) { build :mention_entry }

    specify 'many MentionEntries' do
      role.mention_entries << mention_entry1
      role.mention_entries << mention_entry2
      role.save!

      expect(role).to be_valid
      expect(role.mention_entries).to include mention_entry1, mention_entry2
    end

    specify 'many People through MentionEntries', use_db: true do
      mention_entry1.person = build :person
      mention_entry2.person = build :person, name: Faker::Name.name

      role.mention_entries << mention_entry1
      role.mention_entries << mention_entry2
      role.save!

      expect(role).to be_valid
      expect(role.people).to include mention_entry1.person, mention_entry2.person
    end

    specify 'many Places through MentionEntries', use_db: true do
      mention_entry1.place = build :place
      mention_entry2.place = build :place, title: Faker::Name.title

      role.mention_entries << mention_entry1
      role.mention_entries << mention_entry2
      role.save!

      expect(role).to be_valid
      expect(role.places).to include mention_entry1.place, mention_entry2.place
    end

    specify 'many Deeds through MentionEntries', use_db: true do
      deed = build :deed
      mention_entry1.deed = deed
      mention_entry2.deed = deed
      role.mention_entries << mention_entry1
      role.mention_entries << mention_entry2
      role.save!

      expect(role).to be_valid
      expect(role.deeds).to include mention_entry1.deed, mention_entry2.deed
    end
  end

  describe 'validates' do
    describe 'presence of' do
      it 'title' do
        role.title = nil
        expect(role).not_to be_valid
      end

      it 'referring' do
        role.referring = nil
        expect(role).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'referring' do
        specify "within #{Role::REFERS_TO}" do
          Role::REFERS_TO.each do |valid_ref|
            role.referring = valid_ref
            expect(role).to be_valid
          end

          role.referring = 'not a valid referring type'
          expect(role).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      it 'notes' do
        role.notes = nil
        expect(role).to be_valid
      end
    end
  end
end
