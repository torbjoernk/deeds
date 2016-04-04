require 'rails_helper'
require_relative 'support/iconic_model'

describe Document, type: :model do
  it_behaves_like 'an IconicModel', Document

  let(:document) { build :document }
  let(:collection1) { build :collection }
  let(:collection2) do
    collection = build :collection, title: Faker::Name.title, abbr: Faker::Lorem.characters(5)
    expect(collection1.title).not_to eq collection.title
    expect(collection1.abbr).not_to eq collection.abbr
    collection
  end

  it 'has a valid factory', use_db: true do
    document.save!
    expect(document).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(document.title).to be_a String
    end

    specify 'document_type as string' do
      expect(document.document_type).to be_a String
    end

    specify 'notes as string' do
      expect(document.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many collections', use_db: true do
      document.save!
      document.collections = [collection1, collection2]

      expect(document).to be_valid
      document.save!

      expect(document.collections).to include collection1, collection2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        document.title = nil
        expect(document).not_to be_valid
      end

      specify 'document_type' do
        document.document_type = nil
        expect(document).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title w.r.t. document_type' do
        create(:document)
        expect(document).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'document_type' do
        specify "within #{Document::DOCUMENT_TYPES}" do
          Document::DOCUMENT_TYPES.each do |valid_type|
            document.document_type = valid_type
            expect(document).to be_valid
          end

          document.document_type = 'not a document type'
          expect(document).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        document.notes = nil
        expect(document).to be_valid
      end
    end
  end
end
