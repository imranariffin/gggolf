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
		email: "hillary.clinton@democratic.com"
	},{
		fname: "Bernie",
		lname: "Sanders",
		email: "feelthebern@independent.com"
	},{
		fname: "Jill",
		lname: "Stein",
		email: "jill.stein@green.com"
	},{
		fname: "Donald",
		lname: "Trump",
		email: "donald.trump@republican.com"
	}]

# default set of data for tournaments
default_tournaments = [
	{
		title: "Skule Golf Cup",
		location: "UTSU Lawn",
		description: "Play golf while do charity on our very own UTSU lawn"
	}, {
		title: "Michael Stumm Gold Cup",
		location: "King's College Circle",
		description: "Play golf while do charity on our very own King's College Circle"
	}, {
		title: "BMW PGA Championship",
		location: "Virginia Water, Surrey, UK",
		description: "Raise money for kids fighting cancer"
	}]

# delete to avoid duplicate
Team.destroy_all()
Sponsor.destroy_all()
Player.destroy_all()
User.destroy_all(fname: default_users.map do |u| u[:fname] end)
Tournament.destroy_all(title: default_tournaments.map do |u| u[:title] end)

# add to db
users = User.create(default_users)
tournaments = Tournament.create(default_tournaments)

# tournament only Trump joins
republican_tour = Tournament.create({
	title: "Republican Tour"
	})
team_trump = republican_tour.teams.new()
team_trump.save()
trump = User.find_by(fname: default_users[3][:fname])
trump.players.new(team_id: team_trump[:id]).save()

# Trump organizes and sponsors BMW PGA, everyone else joins
bmw_pga = Tournament.find_by(title: default_tournaments[2][:title])
bmw_admin = bmw_pga.admins.new(user_id: trump[:id])
bmw_admin.save()
bmw_sponsor = bmw_pga.sponsors.new(user_id: trump[:id])
bmw_sponsor.save()

# skule tournament has all default users as players
skule_tour = Tournament.find_by(title: default_tournaments[0][:title])
team = skule_tour.teams.new()
team.save()
users.each do |u|
	player = u.players.new(team_id: team[:id]).save()
end