require 'rails_helper'

describe Place, type: :model do
  context 'has attributes' do
    context 'title' do
      it 'as string' do
        place = create(:place_one)
        expect(place.title).to be_a String
      end

      it 'is required' do
        expect {
          Place.create!(title: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'notes' do
      it 'as string' do
        place = create(:place_one)
        expect(place.notes).to be_a String
      end

      it 'is not required' do
        expect {
          Place.create!(title: 'Title', notes: nil)
        }.not_to raise_error
      end
    end
  end

  context 'has associations with' do
    context 'other places' do
      it 'does have related Places' do
        create(:place_relation_one_two)
        first = Place.find_by attributes_for(:place_one)
        second = Place.find_by attributes_for(:place_two)

        expect(first.related).to include second
      end

      it 'can query for relatives' do
        create(:place_relation_one_two)
        first = Place.find_by attributes_for(:place_one)
        second = Place.find_by attributes_for(:place_two)

        expect(first.related).to include second
        expect(second.relatives).to include first
      end
    end

    context 'people' do
      it 'through mentions' do
        create(:mention_per1_pla1_rol1)
        place = Place.find_by(attributes_for(:place_one))
        person = Person.find_by(attributes_for(:person_one))

        expect(place.mentioned_people).to include person
      end
    end

    context 'roles' do
      it 'through mentions' do
        create(:mention_per1_pla1_rol1)
        place = Place.find_by(attributes_for(:place_one))
        role = Role.find_by(attributes_for(:role_one))

        expect(place.roles).to include role
      end
    end
  end
end
