require 'rails_helper'

describe Content, type: :model do
  let(:content) { build :content }

  it 'has a valid factory', use_db: true do
    content.save!
    expect(content).to be_valid
  end

  describe 'has attributes' do
    specify 'content as text' do
      expect(content.content).to be_a String
    end

    specify 'language as string' do
      expect(content.language).to be_a String
    end

    specify 'notes as text' do
      expect(content.notes).to be_a String
    end
  end

  context 'has association with' do
    specify 'one Deed' do
      deed = build :deed

      content.deed = deed
      expect(content).to be_valid

      expect(content.deed).to eq deed
      expect(deed.content).to eq content
    end

    specify 'many ContentTranslations' do
      translation1 = build :content_translation
      translation2 = build :content_translation
      content.translations << translation1
      content.translations << translation2
      expect(content).to be_valid

      expect(content.translations).to include translation1, translation2
    end
  end

  describe 'validates' do
    describe 'presence of' do
      specify 'content' do
        content.content = nil
        expect(content).not_to be_valid
      end

      specify 'language' do
        content.language = nil
        expect(content).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'language' do
        specify "within #{Content::LANGUAGES}" do
          Content::LANGUAGES.each do |valid_language|
            content.language = valid_language
            expect(content).to be_valid
          end

          content.language = 'not a language'
          expect(content).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        content.notes = nil
        expect(content).to be_valid
      end
    end
  end
end
