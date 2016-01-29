require 'rails_helper'

describe Archive, type: :model do
  context 'has attribute' do
    context 'title' do
      it 'as string' do
        archive = create(:archive_one)
        expect(archive.title).to be_a String
      end

      it 'is required' do
        expect {
          Archive.create!(title: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'must be unique' do
        first = create(:archive_one)
        expect {
          Archive.create!(title: first.title)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'abbr' do
      it 'as string' do
        archive = create(:archive_one)
        expect(archive.abbr).to be_a String
      end

      it 'is not required' do
        expect {
          Archive.create!(title: 'some title', abbr: nil)
        }.not_to raise_error
      end

      it 'must be unique' do
        first = create(:archive_one)
        expect {
          Archive.create!(title: 'another', abbr: first.abbr)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  context 'has associations with' do
    context 'storages' do
      it 'can have multiple' do
        archive = create(:archive_one)
        storage1 = create(:storage_one)
        storage2 = create(:storage_two)

        archive.storages = [storage1, storage2]
        archive.save!

        expect(archive.storages).to include storage1
        expect(archive.storages).to include storage2
      end

      it 'does not allow duplication' do
        archive = create(:archive_one)
        storage1 = create(:storage_one)

        archive.storages = [storage1]
        archive.save!

        expect {
          archive.storages << storage1
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
