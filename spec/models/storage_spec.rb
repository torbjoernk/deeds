require 'rails_helper'

describe Storage, type: :model do
  context 'has attributes' do
    context 'title' do
      it 'as string' do
        storage = create(:storage_one)
        expect(storage.title).to be_a String
      end

      it 'is required' do
        expect {
          Storage.create!(title: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'must be unique' do
        first = create(:storage_one)
        expect {
          Storage.create!(title: first.title)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'notes' do
      it 'as string' do
        storage = create(:storage_one)
        expect(storage.notes).to be_a String
      end

      it 'is not required' do
        expect {
          Storage.create!(title: 't', notes: nil)
        }.not_to raise_error
      end
    end
  end

  context 'has associations with' do
    context 'archives' do
      it 'can have multiple' do
        storage = create(:storage_one)
        archive1 = create(:archive_one)
        archive2 = create(:archive_two)

        storage.archives = [archive1, archive2]
        storage.save!

        expect(storage.archives).to include archive1
        expect(storage.archives).to include archive2
      end

      it 'does not allow duplication' do
        storage = create(:storage_one)
        archive1 = create(:archive_one)

        storage.archives = [archive1]
        storage.save!

        expect {
          storage.archives << archive1
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
