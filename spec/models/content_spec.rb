require 'rails_helper'

describe Content, type: :model do
  context 'has attributes' do
    context 'content' do
      it 'as string' do
        content = create(:content_one)
        expect(content.content).to be_a String
      end

      it 'is required' do
        expect {
          Content.create!(content: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'language' do
      it 'as string' do
        content = create(:content_one)
        expect(content.language).to be_a String
      end

      it 'is required' do
        expect {
          Content.create!(content: 'a text', language: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      Content::LANGUAGES.each do |valid_lang|
        it "accepts language '#{valid_lang}'" do
          expect {
            Content.create!(content: 'a text', language: valid_lang)
          }.not_to raise_error
        end
      end

      it 'does not accept invalid language' do
        expect {
          Content.create!(content: 'a text', language: 'definitively not a language')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  context 'has associations with' do
    context 'deed' do
      it 'belongs to one' do
        content = create(:content_one)
        deed = create(:deed_one)

        content.deed = deed
        content.save!

        expect(content.deed).to eq deed
        expect(deed.content).to eq content
      end
    end

    context 'translations' do
      it 'can have multiple' do
        translation = create(:content_translation_one)
        content = Content.find_by(attributes_for(:content_one))

        expect(content.translations).to include translation
      end
    end
  end
end
