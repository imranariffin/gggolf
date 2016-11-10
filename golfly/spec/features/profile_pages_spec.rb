require 'rails_helper'

RSpec.feature "ProfilePages", type: :feature do

  before :all do
    @user = FactoryGirl.create :user

    @tournament1 = FactoryGirl.create :tournament
    @tournament2 = FactoryGirl.create :tournament
    @tournament3 = FactoryGirl.create :tournament
    @tournament4 = FactoryGirl.create :tournament

    #played in tournament 1 + 2
    @team1 = FactoryGirl.create(:team, tournament: @tournament1)
    @team2 = FactoryGirl.create(:team, tournament: @tournament2)
    @player1 = FactoryGirl.create(:player, user: @user, team: @team1)
    @player2 = FactoryGirl.create(:player, user: @user, team: @team2)

    #admin for tournament 3
    @admin = FactoryGirl.create(:admin, user: @user, tournament: @tournament3)

    #sponsor for tournament 4
    @sponsor = FactoryGirl.create(:sponsor, user: @user, tournament: @tournament4)
  end

  before :each do
    visit user_path(id: @user.id)
  end

  describe 'profile info' do
    it 'should show user name' do
      expect(page).to have_text(@user.name)
    end

    it 'should show user email' do
      expect(page).to have_text(@user.email)
    end

    it 'should show user bio if it exists' do
      expect(page).to have_text(@user.bio)
    end

    it 'should have a button to edit profile' do
      expect(page).to have_button('Edit Profile')

      click_button 'Edit Profile'
      expect(current_path).to eq(edit_user_path(id: @user.id))
    end
  end

  describe 'user tournaments' do
    it 'should have a title' do
      expect(page).to have_text('Your Tournaments')
    end

    it 'should list tournaments user has played in' do
      expect(page).to have_text('Tournaments You Have Played In')
    end

    it 'should list tournaments user has sponsored' do
      expect(page).to have_text('Tournaments You Have Sponsored')
    end

    it 'should list tournaments user is an admin for' do
      expect(page).to have_text('Tournaments You Are An Admin For')
    end
  end
end
