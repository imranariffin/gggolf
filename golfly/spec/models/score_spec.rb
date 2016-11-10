require 'rails_helper'

RSpec.describe Score, type: :model do
  puts "~~Tournament Titles: #{Tournament.pluck :title}~~"
  let(:user) { FactoryGirl.create :user }
  let(:tournament) { FactoryGirl.create :tournament }
  let(:team) { FactoryGirl.create :team, tournament: tournament }
  let(:player) { FactoryGirl.create :player, user: user, team: team }

  before :each do
    @score = FactoryGirl.build :score, player: player
  end

  it 'should be valid' do
    expect(@score).to be_valid
  end

  it 'should have hole present' do
    @score.hole = nil
    expect(@score).to_not be_valid
  end

  it 'should have strokes present' do
    @score.strokes = nil
    expect(@score).to_not be_valid
  end

  it 'should have hole greater than 0' do
    @score.hole = 0
    expect(@score).to_not be_valid
  end

  it 'should have strokes greater than 0' do
    @score.strokes = 0
    expect(@score).to_not be_valid
  end

  it 'should have an associated player' do
    @score.player = nil
    expect(@score).to_not be_valid
  end
end
