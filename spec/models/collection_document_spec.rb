require 'rails_helper'

describe CollectionDocument, type: :model, use_db: true do
  let(:collection)          { create :collection }
  let(:document)            { create :document }
  let(:collection_document) { build :collection_document }

  it 'has a valid factory' do
    collection_document.save!
    expect(collection_document).to be_valid
  end

  describe 'associates' do
    specify 'an Collection with a Document' do
      collection_document.collection = collection
      collection_document.document = document

      collection_document.save!

      expect(collection_document.collection).to eq collection
      expect(collection_document.document).to eq document
    end
  end

  describe 'validates' do
    describe 'uniqueness of' do
      describe 'association' do
        specify 'between Collection and Document' do
          CollectionDocument.create(collection: collection, document: document)

          collection_document.collection = collection
          collection_document.document = document

          expect(collection_document).not_to be_valid
        end
      end
    end
  end
end
