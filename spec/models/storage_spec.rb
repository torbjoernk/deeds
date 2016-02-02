require 'rails_helper'

describe Storage, type: :model do
  before :each do
    @storage = build(:storage)
    @archive1 = build(:archive)
    @archive2 = build(:archive, title: Faker::Name.title, abbr: Faker::Lorem.characters(5))
    expect(@archive1.title).not_to eq @archive2.title
    expect(@archive1.abbr).not_to eq @archive2.abbr
  end

  it 'has a valid factory' do
    @storage.save!
    expect(@storage).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(@storage.title).to be_a String
    end

    specify 'notes as string' do
      expect(@storage.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many Archives' do
      @storage.save!
      @storage.archives = [@archive1, @archive2]
      @storage.save!

      expect(@storage.archives).to include @archive1, @archive2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        @storage.title = nil
        expect(@storage).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title' do
        create(:storage)
        expect(@storage).not_to be_valid
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        @storage.notes = nil
        expect(@storage).to be_valid
      end
    end
  end
end
