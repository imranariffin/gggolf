# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# default set of data for users
default_users = [
	{
		fname: "Hillary",
		lname: "Clinton",
		addr: "15 Old House Ln., Chappaqua, NY",
		email: "hillary.clinton@democratic.com",
		password: "defaultpassword"
	},{
		fname: "Bernie",
		lname: "Sanders",
		addr: "1 Church St, 3rd Floor, Burlington, VT 05401",
		email: "feelthebern@independent.com",
		password: "defaultpassword"
	},{
		fname: "Jill",
		lname: "Stein",
		addr: "17 Trotting Horse Drive, Lexington, MA 02421",
		email: "jill.stein@green.com",
		password: "defaultpassword"
	},{
		fname: "Donald",
		lname: "Trump",
		addr: "725 5th Avenue New York, NY 10022",
		email: "donald.trump@republican.com",
		password: "defaultpassword"
	}]

# default set of data for tournaments
default_tournaments = [
	{
		title: "Skule Golf Cup",
		location: "UTSU Lawn",
		description: "Play golf while do charity on our very own UTSU lawn",
		player_limit: 2
	}, {
		title: "Michael Stumm Gold Cup",
		location: "King's College Circle",
		description: "Play golf while do charity on our very own King's College Circle",
		player_limit: 16
	}, {
		title: "BMW PGA Championship",
		location: "Virginia Water, Surrey, UK",
		description: "Raise money for kids fighting cancer",
		player_limit: 64
	}]

# delete to avoid duplicate
User.destroy_all(fname: default_users.map do |u| u[:fname] end)
Tournament.destroy_all(title: default_tournaments.map do |u| u[:title] end)

# add to db
users = User.create(default_users)
users.each do |u|
	if u.save() == false
		puts u.errors.full_messages
	end
end
tournaments = Tournament.create(default_tournaments)
tournaments.each do |t|
	if t.save() == false
		puts t.errors.full_messages
	end
end

# Trump organizes and sponsors BMW PGA, everyone else joins
trump = User.find_by(fname: default_users[3][:fname])
# trump = User.find_by(email: default_users[3][:email])
bmw_pga = Tournament.find_by(title: default_tournaments[2][:title])
bmw_admin = bmw_pga.admins.new(user_id: trump[:id])
bmw_admin.save()
bmw_sponsor = bmw_pga.sponsors.new(user_id: trump[:id])
bmw_sponsor.save()
all_user_team = bmw_pga.teams.new()
all_user_team.save()
users.each do |u|
	u.players.new(team_id: all_user_team[:id]).save()
end