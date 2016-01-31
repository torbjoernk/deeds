require 'rails_helper'

describe Person, type: :model do
  context 'has attributes' do
    context 'name' do
      it 'as string' do
        person = create(:person_one)
        expect(person.name).to be_a String
      end

      it 'is required' do
        expect {
          Person.create!(name: nil)
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'gender' do
      it 'as string' do
        person = create(:person_one)
        expect(person.gender).to be_a String
      end

      it 'is not required' do
        expect {
          Person.create!(name: 'Name', gender: nil)
        }.not_to raise_error
      end

      Person::GENDERS.each do |valid_gender|
        it "accepts gender '#{valid_gender}'" do
          expect {
            Person.create!(name: "Gender '#{valid_gender}'", gender: valid_gender)
          }.not_to raise_error
        end
      end

      it 'does not save with invalid gender' do
        expect {
          Person.create!(name: 'Tester', gender: 'not a gender')
        }.to raise_error ActiveRecord::RecordInvalid
      end
    end
  end

  it 'ensures uniqueness of Name-Gender combination' do
    first = create(:person_one)

    expect {
      Person.create!(name: first.name, gender: first.gender)
    }.to raise_error ActiveRecord::RecordInvalid
  end
end
