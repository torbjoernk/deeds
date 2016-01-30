require 'rails_helper'

describe Source, type: :model do
  context 'has attribute' do
    context 'title' do
      it 'as string' do
        source = create(:source_one)
        expect(source.title).to be_a String
      end

      it 'is required' do
        expect {
          Source.create!(title: nil, source_type: 'original')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'source_type' do
      it 'as string' do
        source = create(:source_one)
        expect(source.source_type).to be_a String
      end

      it 'is required' do
        expect {
          Source.create!(title: 'title', source_type: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      Source::SOURCE_TYPES.each do |valid_type|
        it "accepts type '#{valid_type}'" do
          expect {
            Source.create!(title: "type #{valid_type}", source_type: valid_type)
          }.not_to raise_error
        end
      end
    end

    context 'notes' do
      it 'as string' do
        source = create(:source_one)
        expect(source.notes).to be_a String
      end

      it 'is not required' do
        expect {
          Source.create(title: 'no notes', source_type: Source::SOURCE_TYPES[0], notes: nil)
        }.not_to raise_error
      end
    end

    it 'ensures uniqueness of Title-SourceType combination' do
      first = create(:source_one)
      expect {
        Source.create!(title: first.title, source_type: first.source_type)
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context 'has association with' do
    context 'archives' do
      it 'is associated with multiple' do
        source = create(:source_one)
        archive = create(:archive_one)

        source.archives << archive
        expect(source.archives).to include archive
      end

      it 'does not allow duplicates' do
        source = create(:source_one)
        archive = create(:archive_one)

        source.archives << archive
        expect {
          source.archives << archive
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end
end
