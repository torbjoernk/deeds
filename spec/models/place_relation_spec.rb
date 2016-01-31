require 'rails_helper'

describe PlaceRelation, type: :model do
  it 'does relate two Places' do
    rel = create(:place_relation_one_two)

    expect(rel.place).to eq Place.find_by(attributes_for(:place_one))
    expect(rel.related).to eq Place.find_by(attributes_for(:place_two))
  end

  it 'does not save two equal relations' do
    rel = build(:place_relation_one_two)
    other = PlaceRelation.new(place: rel.place, related: rel.related, notes: 'another text')

    rel.save!

    expect {
      other.save!
    }.to raise_error ActiveRecord::RecordInvalid
  end
end
