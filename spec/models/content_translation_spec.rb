require 'rails_helper'

describe ContentTranslation, type: :model do
  let(:content) { build :content }
  let(:translation) { build :content_translation }

  it 'has a valid factory' do
    translation.save!
    expect(translation).to be_valid
  end

  describe 'has attributes' do
    specify 'translation as string' do
      expect(translation.translation).to be_a String
    end

    specify 'language as string' do
      expect(translation.language).to be_a String
    end

    specify 'notes as string' do
      expect(translation.notes).to be_a String
    end
  end

  context 'has association with' do
    specify 'one Content' do
      translation.content = content
      translation.save!

      expect(translation.content).to eq content
      expect(content.translations).to include translation
    end

    specify 'one Deed through Content' do
      deed = create :deed
      content.deed = deed

      translation.content = content
      translation.save!

      expect(translation.deed).to eq deed
      expect(deed.translations).to include translation
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'translation' do
        translation.translation = nil
        expect(translation).not_to be_valid
      end

      specify 'language' do
        translation.language = nil
        expect(translation).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'language' do
        specify "within #{Content::LANGUAGES}" do
          Content::LANGUAGES.each do |valid_language|
            translation.language = valid_language
            expect(translation).to be_valid
          end

          translation.language = 'not a language'
          expect(translation).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        translation.notes = nil
        expect(translation).to be_valid
      end
    end
  end
end
