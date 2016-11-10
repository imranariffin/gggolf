require 'rails_helper'

RSpec.describe User, type: :model do
  let(:tournament) { FactoryGirl.create :tournament }
  let(:team) { FactoryGirl.create :team, tournament: tournament }

  before :each do
    @user = FactoryGirl.create :user
    FactoryGirl.create :player, user: @user, team: team
  end

  describe 'name' do
    it 'should return user full name' do
      expect(@user.name).to eq('Joe Blow')
    end
  end

  describe 'player_tournaments' do
    it 'should return tournaments a user has played in' do
      pts = @user.player_tournaments
      expect(pts.size).to eq(1)
      expect(pts.first).to eq(tournament)
    end

    it 'should return an empty association if user has not played in a tournament' do
      @user.players = []
      expect(@user.player_tournaments.size).to eq(0)
    end

    it 'should not return duplicate tournament associations' do
      FactoryGirl.create :player, user: @user, team: team
      expect(@user.players.size).to eq(2)
      puts "upt: #{@user.player_tournaments.to_a}"
      expect(@user.player_tournaments.size).to eq(1)
    end
  end

  describe 'admin_tournaments' do

  end

  describe 'sponsor_tournaments' do

  end
end
