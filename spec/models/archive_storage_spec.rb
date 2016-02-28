require 'rails_helper'

describe ArchiveStorage, type: :model do
  let(:archive) { create :archive }
  let(:storage) { create :storage }
  let(:archive_storage) { build :archive_storage }

  it 'has a valid factory' do
    archive_storage.save!
    expect(archive_storage).to be_valid
  end

  describe 'associates' do
    specify 'an Archive with a Storage' do
      archive_storage.archive = archive
      archive_storage.storage = storage

      archive_storage.save!

      expect(archive_storage.archive).to eq archive
      expect(archive_storage.storage).to eq storage
    end
  end

  describe 'validates' do
    describe 'uniqueness of' do
      describe 'association' do
        specify 'between Archive and Storage' do
          ArchiveStorage.create(archive: archive, storage: storage)

          archive_storage.archive = archive
          archive_storage.storage = storage

          expect(archive_storage).not_to be_valid
        end
      end
    end
  end
end
