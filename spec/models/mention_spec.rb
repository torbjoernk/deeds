require 'rails_helper'

describe Mention, type: :model do
  context 'has attributes' do
    context 'notes' do
      it 'as string' do
        mention = create(:mention_per1_pla1_rol1)
        expect(mention.notes).to be_a String
      end
    end
  end

  context 'has associations with' do
    context 'deed' do
      it 'belongs to a single deed' do
        mention = create(:mention_per1_pla1_rol1)
        deed = create(:deed_one)

        mention.deed = deed
        mention.save!

        expect(mention.deed).to eq deed
        expect(deed.mentions).to include mention
      end
    end

    context 'people' do
      it 'single' do
        mention = create(:mention_per1_pla1_rol1)
        person = Person.find_by(attributes_for(:person_one))

        expect(mention.person).to eq person
      end
    end

    context 'people' do
      it 'single' do
        mention = create(:mention_per1_pla1_rol1)
        place = Place.find_by(attributes_for(:place_one))

        expect(mention.place).to eq place
      end
    end

    context 'roles' do
      it 'single' do
        mention = create(:mention_per1_pla1_rol1)
        role = Role.find_by(attributes_for(:role_one))

        expect(mention.role).to eq role
      end
    end
  end
end
