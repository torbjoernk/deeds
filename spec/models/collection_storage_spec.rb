require 'rails_helper'

describe CollectionStorage, type: :model, use_db: true do
  let(:collection) { create :collection }
  let(:storage) { create :storage }
  let(:collection_storage) { build :collection_storage }

  it 'has a valid factory' do
    collection_storage.save!
    expect(collection_storage).to be_valid
  end

  describe 'associates' do
    specify 'an Collection with a Storage' do
      collection_storage.collection = collection
      collection_storage.storage = storage

      collection_storage.save!

      expect(collection_storage.collection).to eq collection
      expect(collection_storage.storage).to eq storage
    end
  end

  describe 'validates' do
    describe 'uniqueness of' do
      describe 'association' do
        specify 'between Collection and Storage' do
          CollectionStorage.create(collection: collection, storage: storage)

          collection_storage.collection = collection
          collection_storage.storage = storage

          expect(collection_storage).not_to be_valid
        end
      end
    end
  end
end
