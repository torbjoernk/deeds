require 'rails_helper'
require_relative 'support/iconic_model'

describe Storage, type: :model do
  it_behaves_like 'an IconicModel', Storage

  let(:storage) { build :storage }
  let(:collection1) { build :collection }
  let(:collection2) do
    collection = build :collection, title: Faker::Name.title, abbr: Faker::Lorem.characters(5)
    expect(collection1.title).not_to eq collection.title
    expect(collection1.abbr).not_to eq collection.abbr
    collection
  end

  it 'has a valid factory', use_db: true do
    storage.save!
    expect(storage).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(storage.title).to be_a String
    end

    specify 'notes as string' do
      expect(storage.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many collections', use_db: true do
      storage.save!
      storage.collections = [collection1, collection2]
      storage.save!

      expect(storage.collections).to include collection1, collection2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        storage.title = nil
        expect(storage).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title', use_db: true do
        create(:storage)
        expect(storage).not_to be_valid
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        storage.notes = nil
        expect(storage).to be_valid
      end
    end
  end
end
