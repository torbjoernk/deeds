require 'rails_helper'

describe ArchiveSource, type: :model do
  before :each do
    @archive = create(:archive)
    @source = create(:source)
    @archive_source = build(:archive_source)
  end

  it 'has a valid factory' do
    @archive_source.save!
    expect(@archive_source).to be_valid
  end

  describe 'associates' do
    specify 'an Archive with a Source' do
      @archive_source.archive = @archive
      @archive_source.source = @source

      @archive_source.save!

      expect(@archive_source.archive).to eq @archive
      expect(@archive_source.source).to eq @source
    end
  end

  describe 'validates' do
    describe 'uniqueness of' do
      describe 'association' do
        specify 'between Archive and Source' do
          ArchiveSource.create(archive: @archive, source: @source)

          @archive_source.archive = @archive
          @archive_source.source = @source

          expect(@archive_source).not_to be_valid
        end
      end
    end
  end
end
