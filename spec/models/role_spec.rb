require 'rails_helper'

describe Role, type: :model do
  context 'has attributes' do
    context 'title' do
      it 'as string' do
        role = create(:role_one)
        expect(role.title).to be_a String
      end

      it 'is required' do
        expect {
          Role.create!(title: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'referring' do
      it 'as string' do
        role = create(:role_one)
        expect(role.referring).to be_a String
      end

      it 'is required' do
        expect {
          Role.create!(title: 'Title', referring: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      Role::REFERS_TO.each do |valid_ref|
        it "accepts referring to '#{valid_ref}'" do
          expect {
            Role.create!(title: 'Title', referring: valid_ref)
          }.not_to raise_error
        end
      end

      it 'does not accept invalid referring' do
        expect {
          Role.create!(title: 'Title', referring: 'this is not a referring identifier')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'notes' do
      it 'as string' do
        role = create(:role_one)
        expect(role.notes).to be_a String
      end

      it 'is not required' do
        expect {
          Role.create!(title: 'Title', referring: 'place', notes: nil)
        }.not_to raise_error
      end
    end
  end

  context 'has associations with' do
    context 'people' do
      it 'through mentions' do
        create(:mention_per1_pla1_rol1)
        role = Role.find_by(attributes_for(:role_one))
        person = Person.find_by(attributes_for(:person_one))

        expect(role.people).to include person
      end
    end

    context 'places' do
      it 'through mentions' do
        create(:mention_per1_pla1_rol1)
        role = Role.find_by(attributes_for(:role_one))
        place = Place.find_by(attributes_for(:place_one))

        expect(role.places).to include place
      end
    end
  end
end
