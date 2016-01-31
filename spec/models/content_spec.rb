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
end
