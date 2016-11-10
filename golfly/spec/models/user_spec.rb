require 'rails_helper'

RSpec.describe User, type: :model do
  let(:tournament) { FactoryGirl.create :tournament }
  let(:team) { FactoryGirl.create :team, tournament: tournament }

  before :each do
    @user = FactoryGirl.create :user
    FactoryGirl.create :player, user: @user, team: team
    FactoryGirl.create :admin, user: @user, tournament: tournament
    FactoryGirl.create :sponsor, user: @user, tournament: tournament
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
      expect(@user.player_tournaments.size).to eq(1)
    end
  end

  describe 'admin_tournaments' do
    it 'should return tournaments a user is an admin for' do
      ats = @user.admin_tournaments
      expect(ats.size).to eq(1)
      expect(ats.first).to eq(tournament)
    end

    it 'should return an empty association if not an admin for a tournament' do
      @user.admins = []
      expect(@user.admin_tournaments.size).to eq(0)
    end

    it 'should not return duplicate tournament associations' do
      FactoryGirl.create :admin, user: @user, tournament: tournament
      expect(@user.admins.size).to eq(2)
      expect(@user.player_tournaments.size).to eq(1)
    end
  end

  describe 'sponsor_tournaments' do
    it 'should return tournaments a user is a sponsor for' do
      sts = @user.sponsor_tournaments
      expect(sts.size).to eq(1)
      expect(sts.first).to eq(tournament)
    end

    it 'should return an empty association if not a sponsor for a tournament' do
      @user.sponsors = []
      expect(@user.sponsor_tournaments.size).to eq(0)
    end

    it 'should not return duplicate tournament associations' do
      FactoryGirl.create :sponsor, user: @user, tournament: tournament
      expect(@user.sponsors.size).to eq(2)
      expect(@user.sponsor_tournaments.size).to eq(1)
    end
  end
end
