require 'rails_helper'

describe Source, type: :model do
  before :each do
    @source = build(:source)
    @archive1 = build(:archive)
    @archive2 = build(:archive, title: Faker::Name.title, abbr: Faker::Lorem.characters(5))
    expect(@archive1.title).not_to eq @archive2.title
    expect(@archive1.abbr).not_to eq @archive2.abbr
  end

  it 'has a valid factory' do
    @source.save!
    expect(@source).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(@source.title).to be_a String
    end

    specify 'source_type as string' do
      expect(@source.source_type).to be_a String
    end

    specify 'notes as string' do
      expect(@source.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many Archives' do
      @source.save!
      @source.archives = [@archive1, @archive2]

      expect(@source).to be_valid
      @source.save!

      expect(@source.archives).to include @archive1, @archive2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        @source.title = nil
        expect(@source).not_to be_valid
      end

      specify 'source_type' do
        @source.source_type = nil
        expect(@source).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title w.r.t. source_type' do
        create(:source)
        expect(@source).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'source_type' do
        specify "within #{Source::SOURCE_TYPES}" do
          Source::SOURCE_TYPES.each do |valid_type|
            @source.source_type = valid_type
            expect(@source).to be_valid
          end
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        @source.notes = nil
        expect(@source).to be_valid
      end
    end
  end
end
