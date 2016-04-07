require 'rails_helper'

describe Deed, type: :model do
  let(:deed) { build :deed }

  context 'has attribute' do
    specify 'title as string' do
      expect(deed.title).to be_a String
    end

    specify 'year as integer' do
      expect(deed.year).to be_an Integer

      deed.year = Faker::Lorem.word
      expect(deed).not_to be_valid
    end

    specify 'month as integer' do
      expect(deed.month).to be_an Integer

      deed.month = Faker::Lorem.word
      expect(deed).not_to be_valid
    end

    specify 'day as integer' do
      expect(deed.day).to be_an Integer

      deed.day = Faker::Lorem.word
      expect(deed).not_to be_valid
    end

    specify 'description as text' do
      expect(deed.description).to be_a String
    end

    specify 'notes as text' do
      expect(deed.notes).to be_a String
    end
  end

  describe 'has association with' do
    let(:mention_entry1) { build :mention_entry }
    let(:mention_entry2) { build :mention_entry }

    specify 'many Documents' do
      document1 = build :document, document_type: 'original'
      document2 = build :document, document_type: 'transcript'
      deed.documents << document1
      deed.documents << document2
      deed.save!

      expect(deed).to be_valid
      expect(deed.documents).to include document1
      expect(document1.deed).to eq deed
      expect(deed.documents).to include document2
      expect(document2.deed).to eq deed
    end

    specify 'one Content' do
      content = build :content

      deed.content = content

      expect(deed).to be_valid
      expect(deed.content).to eq content
      expect(content.deed).to eq deed
    end

    specify 'many ContentTranslations through Content', use_db: true do
      content = build :content
      translation = build(:content_translation)
      content.translations << translation

      deed.content = content
      content.save!

      expect(deed).to be_valid
      expect(deed.translations).to include translation
      expect(translation.deed).to eq deed
    end

    specify 'many MentionEntries', use_db: true do
      deed.mention_entries << mention_entry1
      deed.mention_entries << mention_entry2
      deed.save!

      expect(deed).to be_valid
      expect(deed.mention_entries).to include mention1, mention2
    end

    specify 'many People through MentionEntries', use_db: true do
      mention_entry1.person = build :person
      mention_entry2.person = build :person, name: Faker::Name.name

      deed.mention_entries << mention_entry1
      deed.mention_entries << mention_entry2
      deed.save!

      expect(deed).to be_valid
      expect(deed.people).to include mention_entry1.person, mention_entry2.person
    end

    specify 'many Places through MentionEntries', use_db: true do
      mention_entry1.place = build :place
      mention_entry2.place = build :place, title: Faker::Name.title

      deed.mention_entries << mention_entry1
      deed.mention_entries << mention_entry2
      deed.save!

      expect(deed).to be_valid
      expect(deed.places).to include mention_entry1.place, mention_entry2.place
    end

    specify 'many Roles through MentionEntries', use_db: true do
      mention_entry1.role = build :role
      mention_entry2.role = build :role, title: Faker::Name.title

      deed.mention_entries << mention_entry1
      deed.mention_entries << mention_entry2
      deed.save!

      expect(deed).to be_valid
      expect(deed.roles).to include mention_entry1.role, mention_entry2.role
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        deed.title = nil
        expect(deed).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'month' do
        specify "within #{[1..12]}" do
          [1..12].each do |month_value|
            deed.month = month_value
            expect(deed).to be_valid
          end

          deed.month = 0
          expect(deed).not_to be_valid
          deed.month = 13
          expect(deed).not_to be_valid
        end
      end

      describe 'day' do
        specify "within #{[1..31]}" do
          [1..31].each do |day_value|
            deed.day = day_value
            expect(deed).to be_valid
          end

          deed.day = 0
          expect(deed).not_to be_valid
          deed.day = 32
          expect(deed).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'year' do
        deed.year = nil
        expect(deed).to be_valid
      end

      specify 'month' do
        deed.month = nil
        expect(deed).to be_valid
      end

      specify 'day' do
        deed.day = nil
        expect(deed).to be_valid
      end

      specify 'description' do
        deed.description = nil
        expect(deed).to be_valid
      end

      specify 'notes' do
        deed.notes = nil
        expect(deed).to be_valid
      end
    end
  end
end
