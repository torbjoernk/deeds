require 'rails_helper'

describe DeedFormat, type: :model do
  context 'has attributes' do
    context 'material' do
      it 'as string' do
        format = create(:deed_format_one)
        expect(format.material).to be_a String
      end

      it 'is required' do
        expect {
          create(:deed_format_one, material: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      DeedFormat::MATERIALS.each do |valid_material|
        it "accepts material '#{valid_material}'" do
          expect {
            create(:deed_format_one, material: valid_material)
          }.not_to raise_error
        end
      end

      it 'does not accept invalid material key' do
        expect {
          create(:deed_format_one, material: 'not a material key')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'width' do
      it 'as float' do
        format = create(:deed_format_one)
        expect(format.width).to be_a Float

        expect {
          create(:deed_format_one, width: 'a string')
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'is not required' do
        expect {
          create(:deed_format_one, width: nil)
        }.not_to raise_error
      end

      it 'must be greater 0.0' do
        expect {
          create(:deed_format_one, width: 0.0)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'height' do
      it 'as float' do
        format = create(:deed_format_one)
        expect(format.height).to be_a Float

        expect {
          create(:deed_format_one, width: 'a string')
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it 'is not required' do
        expect {
          create(:deed_format_one, height: nil)
        }.not_to raise_error
      end

      it 'must be greater 0.0' do
        expect {
          create(:deed_format_one, height: 0.0)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  context 'has associations with' do
    context 'deed' do
      it 'belongs to one' do
        format = create(:deed_format_one)
        deed = create(:deed_one)

        format.deed = deed
        format.save!

        expect(format.deed).to eq deed
        expect(deed.formats).to include format
      end
    end
  end
end
