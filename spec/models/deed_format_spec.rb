require 'rails_helper'

describe DeedFormat, type: :model do
  before :each do
    @deed_format = build(:deed_format)
  end

  it 'has a valid factory' do
    @deed_format.save!
    expect(@deed_format).to be_valid
  end

  describe 'has attribute' do
    specify 'material as string' do
      expect(@deed_format.material).to be_a String
    end

    specify 'width as float' do
      expect(@deed_format.width).to be_a Float

      @deed_format.width = 'a string'
      expect(@deed_format).not_to be_valid
    end

    specify 'height as float' do
      expect(@deed_format.height).to be_a Float

      @deed_format.height = 'a string'
      expect(@deed_format).not_to be_valid
    end
  end

  context 'has association with' do
    specify 'one Deed' do
      deed = build(:deed)

      @deed_format.deed = deed
      @deed_format.save!

      expect(@deed_format.deed).to eq deed
      expect(deed.formats).to include @deed_format
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'material' do
        @deed_format.material = nil
        expect(@deed_format).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'material' do
        specify "within #{DeedFormat::MATERIALS}" do
          DeedFormat::MATERIALS.each do |valid_material|
            @deed_format.material = valid_material
            expect(@deed_format).to be_valid
          end

          @deed_format.material = 'not a material'
          expect(@deed_format).not_to be_valid
        end
      end

      describe 'width' do
        specify 'must be greater 0.0' do
          @deed_format.width = 0.0
          expect(@deed_format).not_to be_valid

          @deed_format.width = Faker::Number.positive
          expect(@deed_format).to be_valid
        end
      end

      describe 'height' do
        specify 'must be greater 0.0' do
          @deed_format.height = 0.0
          expect(@deed_format).not_to be_valid

          @deed_format.height = Faker::Number.positive
          expect(@deed_format).to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'width' do
        @deed_format.width = nil
        expect(@deed_format).to be_valid
      end

      specify 'height' do
        @deed_format.height = nil
        expect(@deed_format).to be_valid
      end
    end
  end
end
