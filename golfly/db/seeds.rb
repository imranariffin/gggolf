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
		fname: 'Hillary',
		lname: 'Clinton',
		email: 'hillary.clinton@democratic.com',
    dob: Date.new(1947, 10, 26)
	},{
		fname: 'Bernie',
		lname: 'Sanders',
		email: 'feelthebern@independent.com',
    dob: Date.new(1941, 9, 8)
	},{
		fname: 'Jill',
		lname: 'Stein',
		email: 'jill.stein@green.com',
    dob: Date.new(1950, 5, 14)
	},{
		fname: 'Donald',
		lname: 'Trump',
		email: 'donald.trump@republican.com',
    dob: Date.new(1946, 6, 14)
	}
]

# default set of data for tournaments
default_tournaments = [
	{
		title: 'Skule Golf Cup',
		location: 'UTSU Lawn',
		description: 'Play golf while do charity on our very own UTSU lawn',
		start_datetime: DateTime.new(2016,1,1,0,0,0),
		end_datetime: DateTime.new(2016,1,2,0,0,0)
	}, {
		title: 'Michael Stumm Gold Cup',
		location: "King's College Circle",
		description: "Play golf while do charity on our very own King's College Circle",
		start_datetime: DateTime.new(2016,1,3,0,0,0),
		end_datetime: DateTime.new(2016,1,4,0,0,0)
	}, {
		title: 'BMW PGA Championship',
		location: 'Virginia Water, Surrey, UK',
		description: 'Raise money for kids fighting cancer',
		start_datetime: DateTime.new(2016,2,1,0,0,0),
		end_datetime: DateTime.new(2016,2,2,0,0,0)
	}]

# delete to avoid duplicate
Team.destroy_all
Sponsor.destroy_all
Player.destroy_all
User.where(email: default_users.map {|u| u[:email] }).destroy_all
Tournament.where(title: default_tournaments.map {|u| u[:email] }).destroy_all

# add to db
users = User.create!(default_users)
Tournament.create!(default_tournaments)

# tournament only Trump joins
republican_tour = Tournament.create title: 'Republican Tour', start_datetime: DateTime.new(2016,2,3,0,0,0), end_datetime: DateTime.new(2016,2,4,0,0,0)
team_trump = republican_tour.teams.create
trump = User.find_by email: default_users[3][:email]
trump.players.create(team_id: team_trump[:id])

# Trump organizes and sponsors BMW PGA, everyone else joins
bmw_pga = Tournament.find_by title: default_tournaments[2][:title]
bmw_pga.admins.create user_id: trump[:id]
bmw_pga.sponsors.create user_id: trump[:id]

# skule tournament has all default users as players
skule_tour = Tournament.find_by(title: default_tournaments[0][:title])
team = skule_tour.teams.create

users.each do |u|
	u.players.create team_id: team[:id]
end