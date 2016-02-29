require 'rails_helper'

describe Archive, type: :model do
  let(:archive) { build :archive }
  let(:storage1) { build :storage }
  let(:storage2) do
    storage = build :storage, title: Faker::Name.title
    expect(storage1.title).not_to eq storage.title
    storage
  end
  let(:source1) { build :source }
  let(:source2) do
    source = build :source, title: Faker::Name.title
    expect(source1.title).not_to eq source.title
    source
  end

  it 'has a valid factory', use_db: true do
    archive.save!
    expect(archive).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(archive.title).to be_a String
    end

    specify 'abbr as string' do
      expect(archive.abbr).to be_a String
    end

    specify 'notes as text' do
      expect(archive.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'many Storages', use_db: true do
      archive.save!
      archive.storages = [storage1, storage2]

      expect(archive).to be_valid
      archive.save!

      expect(archive.storages).to include storage1, storage2
    end

    specify 'many Sources', use_db: true do
      archive.save!
      archive.sources = [source1, source2]

      expect(archive).to be_valid
      archive.save!

      expect(archive.sources).to include source1, source2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'title' do
        archive.title = nil
        expect(archive).not_to be_valid
      end
    end

    describe 'uniqueness of' do
      specify 'title', use_db: true do
        create(:archive)
        expect(archive).not_to be_valid
      end

      specify 'abbr', use_db: true do
        create(:archive)
        expect(archive).not_to be_valid
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'abbr' do
        archive.abbr = nil
        expect(archive).to be_valid
      end

      specify 'notes' do
        archive.abbr = nil
        expect(archive).to be_valid
      end

      describe 'association with' do
        specify 'Storage' do
          archive.storages = []
          expect(archive).to be_valid
        end

        specify 'Source' do
          archive.sources = []
          expect(archive).to be_valid
        end
      end
    end
  end
end
