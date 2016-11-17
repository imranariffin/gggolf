require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:team) { FactoryGirl.create :team }
  it 'should be valid' do
    expect(team).to be_valid
  end

  it 'should have players' do
    expect(team.players).to exist
  end

  it 'should be able to get the total score' do
    expect(team.total_score).to be(10)
  end
end
