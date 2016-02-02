require 'rails_helper'

describe Role, type: :model do
  before :each do
    @role = build(:role)
  end

  it 'has a valid factory' do
    @role.save!
    expect(@role).to be_valid
  end

  describe 'has attribute' do
    specify 'title as string' do
      expect(@role.title).to be_a String
    end

    specify 'referring as string' do
      expect(@role.referring).to be_a String
    end

    specify 'notes as text' do
      expect(@role.notes).to be_a String
    end
  end

  context 'has association with' do
    before :each do
      @mention1 = build(:mention_per1_pla1_rol1)
      @mention2 = build(:mention_per2_pla2_rol1)
    end

    specify 'many Mentions' do
      @role.mentions << @mention1
      @role.mentions << @mention2
      @role.save!

      expect(@role).to be_valid
      expect(@role.mentions).to include @mention1, @mention2
    end

    specify 'many People through Mentions' do
      @role.mentions << @mention1
      @role.mentions << @mention2
      @role.save!

      expect(@role).to be_valid
      expect(@role.people).to include @mention1.person, @mention2.person
    end

    specify 'many Places through Mentions' do
      @role.mentions << @mention1
      @role.mentions << @mention2
      @role.save!

      expect(@role).to be_valid
      expect(@role.places).to include @mention1.place, @mention2.place
    end

    specify 'many Deeds through Mentions' do
      deed = build(:deed)
      @mention1.deed = deed
      @mention2.deed = deed
      @role.mentions << @mention1
      @role.mentions << @mention2
      @role.save!

      expect(@role).to be_valid
      expect(@role.deeds).to include @mention1.deed, @mention2.deed
    end
  end

  describe 'validates' do
    describe 'presence of' do
      it 'title' do
        @role.title = nil
        expect(@role).not_to be_valid
      end

      it 'referring' do
        @role.referring = nil
        expect(@role).not_to be_valid
      end
    end

    describe 'value of' do
      describe 'referring' do
        specify "within #{Role::REFERS_TO}" do
          Role::REFERS_TO.each do |valid_ref|
            @role.referring = valid_ref
            expect(@role).to be_valid
          end

          @role.referring = 'not a valid referring type'
          expect(@role).not_to be_valid
        end
      end
    end
  end

  describe 'allows' do
    describe 'absence of' do
      it 'notes' do
        @role.notes = nil
        expect(@role).to be_valid
      end
    end
  end
end
