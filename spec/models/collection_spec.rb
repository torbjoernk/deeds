require 'rails_helper'
require_relative 'support/iconic_model'

describe Collection, type: :model do
  it_behaves_like 'an IconicModel', Collection

  let(:collection) { build :collection }
  let(:storage1) { build :storage }
  let(:storage2) do
    storage = build :storage, title: Faker::Name.title
    expect(storage1.title).not_to eq storage.title
    storage
  end
  let(:document1) { build :document }
  let(:document2) do
    document = build :document, title: Faker::Name.title
    expect(document1.title).not_to eq document.title
    document
  end

  it 'has a valid factory', use_db: true do
    collection.save!
    expect(collection).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(collection.title).to be_a String
    end

    specify 'abbr as string' do
      expect(collection.abbr).to be_a String
    end

    specify 'notes as text' do
      expect(collection.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many Storages', use_db: true do
      collection.save!
      collection.storages = [storage1, storage2]

      expect(collection).to be_valid
      collection.save!

      expect(collection.storages).to include storage1, storage2
    end

    specify 'many Documents', use_db: true do
      collection.save!
      collection.documents = [document1, document2]

      expect(collection).to be_valid
      collection.save!

      expect(collection.documents).to include document1, document2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        collection.title = nil
        expect(collection).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title', use_db: true do
        create(:collection)
        expect(collection).not_to be_valid
      end

      specify 'abbr', use_db: true do
        create(:collection)
        expect(collection).not_to be_valid
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'abbr' do
        collection.abbr = nil
        expect(collection).to be_valid
      end

      specify 'notes' do
        collection.abbr = nil
        expect(collection).to be_valid
      end

      describe 'association with' do
        specify 'Storage' do
          collection.storages = []
          expect(collection).to be_valid
        end

        specify 'Document' do
          collection.documents = []
          expect(collection).to be_valid
        end
      end
    end
  end
end
