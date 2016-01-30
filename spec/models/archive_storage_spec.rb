require 'rails_helper'

describe ArchiveStorage, type: :model do
  it 'associates an Archive with a Storage' do
    archive_storage = create(:archive_storage_one)

    expect(archive_storage.archive).to eq Archive.first
    expect(archive_storage.storage).to eq Storage.first
  end

  it 'does not allow duplicated associations' do
    first = create(:archive_storage_one)

    expect {
      ArchiveStorage.create!(archive: first.archive, storage: first.storage)
    }.to raise_error ActiveRecord::RecordInvalid
  end
end
