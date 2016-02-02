require 'rails_helper'

describe Mention, type: :model do
  before :each do
    @mention = build(:mention)
  end

  it 'has a valid factory' do
    @mention.save!
    expect(@mention).to be_valid
  end

  describe 'has attribute' do
    specify 'notes as string' do
      expect(@mention.notes).to be_a String
    end
  end

  describe 'has association with' do
    specify 'one Deed' do
      deed = build(:deed)

      @mention.deed = deed
      @mention.save!

      expect(@mention).to be_valid
      expect(@mention.deed).to eq deed
      expect(deed.mentions).to include @mention
    end

    specify 'one Person' do
      person = build(:person)

      @mention.person = person
      @mention.save!

      expect(@mention).to be_valid
      expect(@mention.person).to eq person
      expect(person.mentions).to include @mention
    end

    specify 'one Place' do
      place = build(:place)

      @mention.place = place
      @mention.save!

      expect(@mention).to be_valid
      expect(@mention.place).to eq place
      expect(place.mentions).to include @mention
    end

    specify 'one Role' do
      role = build(:role)

      @mention.role = role
      @mention.save!

      expect(@mention).to be_valid
      expect(@mention.role).to eq role
      expect(role.mentions).to include @mention
    end
  end

  describe 'allows' do
    describe 'absence of' do
      specify 'notes' do
        @mention.notes = nil
        expect(@mention).to be_valid
      end
    end
  end
end
