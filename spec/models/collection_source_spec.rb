require 'rails_helper'

describe CollectionSource, type: :model, use_db: true do
  let(:collection)        { create :collection }
  let(:source)         { create :source }
  let(:collection_source) { build :collection_source }

  it 'has a valid factory' do
    collection_source.save!
    expect(collection_source).to be_valid
  end

  describe 'associates' do
    specify 'an Collection with a Source' do
      collection_source.collection = collection
      collection_source.source = source

      collection_source.save!

      expect(collection_source.collection).to eq collection
      expect(collection_source.source).to eq source
    end
  end

  describe 'validates' do
    describe 'uniqueness of' do
      describe 'association' do
        specify 'between Collection and Source' do
          CollectionSource.create(collection: collection, source: source)

          collection_source.collection = collection
          collection_source.source = source

          expect(collection_source).not_to be_valid
        end
      end
    end
  end
end
