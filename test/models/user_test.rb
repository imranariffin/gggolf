require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "new user with existing email should fail save" do
  	user = User.new(
  		:fname => "Imran",
  		:lname => "Ariffin",
  		:phone => 123456789,
  		# this email already exists
  		:email => "imranariffin@gmail.com",
  		:addr => "15 Ross St M5T 1Z8 Toronto",
  		:password => "defaultpassword")
    assert user.save()==false, user.errors.messages
  end

  test "new user with unmatching password confirmation should fail save" do
  	user = User.new(
  		:fname => "Imran",
  		:lname => "Ariffin",
  		:phone => 123456789,
  		:email => "michaelstumm@gmail.com",
  		:addr => "15 Ross St M5T 1Z8 Toronto",
  		:password => "defaultpassword", 
  		# password confirmation doesn't match
  		:password_confirmation => "passwordnotmatch")

  	assert user.save()==false, user.errors.messages
  end

  # test "should exist only at most once as a player in tournament" do
  # 	tournament = tournaments(:one)
  # 	new_team = tournament.teams.new()
  # 	new_team2 = tournament.teams.new()
  # 	new_team.save()
  # 	new_team2.save()

  # 	user = users(:one)

  # 	player = user.players.new(:team_id => new_team[:id])
  # 	player2 = user.players.new(:team_id => new_team2[:id])
  # 	player.save()
  # 	player2.save()

  # 	assert user.save()==false, user.errors.messages
  # end
end
