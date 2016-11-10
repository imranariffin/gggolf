require 'rails_helper'

RSpec.feature "ProfilePages", type: :feature do
  before :all do
    @user = FactoryGirl.create :user
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

    it 'should list tournaments user has played in'

    it 'should list tournaments user has sponsored'
    it 'should list tournaments user is an admin for'
  end
end
