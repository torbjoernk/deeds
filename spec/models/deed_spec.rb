require 'rails_helper'

describe Deed, type: :model do
  context 'has attributes' do
    context 'title' do
      it 'as string' do
        deed = create(:deed_one)
        expect(deed.title).to be_a String
      end

      it 'is required' do
        expect {
          create(:deed_one, title: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'year' do
      it 'as integer' do
        deed = create(:deed_one)
        expect(deed.year).to be_a Integer

        expect {
          create(:deed_one, year: 'a string')
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'is not required' do
        expect {
          create(:deed_one, year: nil)
        }.not_to raise_error
      end
    end

    context 'month' do
      it 'as integer' do
        deed = create(:deed_one)
        expect(deed.month).to be_a Integer

        expect {
          create(:deed_one, month: 'a string')
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'is not required' do
        expect {
          create(:deed_one, month: nil)
        }.not_to raise_error
      end

      it 'must be within 1..12' do
        [1..12].each do |val|
          expect {
            create(:deed_one, month: val)
          }.not_to raise_error
        end

        expect {
          create(:deed_one, month: 0)
        }.to raise_error ActiveRecord::RecordInvalid

        expect {
          create(:deed_one, month: 13)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'day' do
      it 'as integer' do
        deed = create(:deed_one)
        expect(deed.day).to be_a Integer

        expect {
          create(:deed_one, day: 'a string')
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'is not required' do
        expect {
          create(:deed_one, day: nil)
        }.not_to raise_error
      end

      it 'must be within 1..31' do
        [1..31].each do |val|
          expect {
            create(:deed_one, month: val)
          }.not_to raise_error
        end

        expect {
          create(:deed_one, month: 0)
        }.to raise_error ActiveRecord::RecordInvalid

        expect {
          create(:deed_one, month: 32)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'description' do
      it 'as string' do
        deed = create(:deed_one)
        expect(deed.description).to be_a String
      end

      it 'is not required' do
        expect {
          create(:deed_one, description: nil)
        }.not_to raise_error
      end
    end

    context 'notes' do
      it 'as string' do
        deed = create(:deed_one)
        expect(deed.notes).to be_a String
      end

      it 'is not required' do
        expect {
          create(:deed_one, notes: nil)
        }.not_to raise_error
      end
    end
  end

  context 'has associations with' do
    context 'deed format' do
      it 'multiple' do
        deed = create(:deed_one)
        format1 = create(:deed_format_one)
        format2 = create(:deed_format_one, material: 'paper')
        deed.formats << format1
        deed.formats << format2
        deed.save!

        expect(deed.formats).to include format1
        expect(format1.deed).to eq deed
        expect(deed.formats).to include format2
        expect(format2.deed).to eq deed
      end
    end
  end
end
