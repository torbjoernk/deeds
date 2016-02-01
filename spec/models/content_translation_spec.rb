require 'rails_helper'

describe ContentTranslation, type: :model do
  context 'has attributes' do
    context 'translation' do
      it 'as string' do
        translation = create(:content_translation_one)
        expect(translation.translation).to be_a String
      end

      it 'is required' do
        expect {
          create(:content_translation_one, translation: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'language' do
      it 'as string' do
        translation = create(:content_translation_one)
        expect(translation.language).to be_a String
      end

      it 'is required' do
        expect {
          create(:content_translation_one, language: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      Content::LANGUAGES.each do |valid_lang|
        it "accepts language '#{valid_lang}'" do
          expect {
            create(:content_translation_one, language: valid_lang)
          }.not_to raise_error
        end
      end

      it 'does not accept invalid language' do
        expect {
          create(:content_translation_one, language: 'not a language key')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'notes' do
      it 'as string' do
        translation = create(:content_translation_one)
        expect(translation.notes).to be_a String
      end

      it 'is not required' do
        expect {
          create(:content_translation_one, notes: nil)
        }.not_to raise_error
      end
    end
  end

  context 'has associations with' do
    context 'content' do
      it 'belongs to' do
        translation = create(:content_translation_one)
        content = Content.find_by(attributes_for(:content_one))

        expect(translation.content).to eq content
      end
    end

    context 'deed' do
      it 'belongs to one through content' do
        translation = create(:content_translation_one)
        deed = create(:deed_one)

        deed.content = translation.content
        deed.save!

        expect(translation.deed).to eq deed
        expect(deed.translations).to include translation
      end
    end
  end
end
