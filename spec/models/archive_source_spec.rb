require 'rails_helper'

describe ArchiveSource, type: :model do
  it 'associates an Archive with a Source' do
    archive_source = create(:archive_source_one)
    expect(archive_source.archive).to be_an(Archive)
    expect(archive_source.source).to be_a(Source)
  end

  it 'does not allow duplicated associations' do
    first = create(:archive_source_one)
    expect {
      ArchiveSource.create!(archive: first.archive, source: first.source)
    }.to raise_error ActiveRecord::RecordInvalid
  end
end
