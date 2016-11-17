require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:tournament) { FactoryGirl.create :tournament }
  let(:user) { FactoryGirl.create :user }
  before :each do
    @team = FactoryGirl.create :team, tournament: tournament
  end

  it 'should be valid' do
    expect(@team).to be_valid
  end

  it 'should belong to a tournament' do
    @team.tournament = nil
    expect(@team).to_not be_valid
  end

  it 'should be able to get the total score' do
    5.times do
      @team.players << FactoryGirl.create(:player, user: user, team: @team)
    end
    expect(@team.total_score).to be(10)
  end
end