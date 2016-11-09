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
		description: 'Play golf while do charity on our very own UTSU lawn'
	}, {
		title: 'Michael Stumm Gold Cup',
		location: "King's College Circle",
		description: "Play golf while do charity on our very own King's College Circle"
	}, {
		title: 'BMW PGA Championship',
		location: 'Virginia Water, Surrey, UK',
		description: 'Raise money for kids fighting cancer'
	}]

# delete to avoid duplicate
User.where(email: default_users.map {|u| u[:email] }).destroy_all
Tournament.where(title: default_tournaments.map {|u| u[:email] }).destroy_all

# add to db
users = User.create!(default_users)
tournaments = Tournament.create!(default_tournaments)

# tournament only Trump joins
republican_tour = Tournament.create title: 'Republican Tour'
team_trump = republican_tour.teams.create
trump = User.find_by email: default_users[3][:email]
trump.players.create(team_id: team_trump[:id])

# Trump organizes and sponsors BMW PGA, everyone else joins
bmw_pga = Tournament.find_by title: default_tournaments[2][:title]
bmw_admin = bmw_pga.admins.create user_id: trump[:id]
bmw_sponsor = bmw_pga.sponsors.create user_id: trump[:id]

# skule tournament has all default users as players
skule_tour = Tournament.find_by(title: default_tournaments[0][:title])
team = skule_tour.teams.create

users.each do |u|
	u.players.create team_id: team[:id]
end

  # create_table "tournaments", force: :cascade do |t|
  #   t.string   "title"
  #   t.string   "location"
  #   t.datetime "start"
  #   t.datetime "end"
  #   t.text     "description"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  # end