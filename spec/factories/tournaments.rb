FactoryGirl.define do
  factory :tournament do
    sequence(:title) { |n| "Golf Tournament #{n}" }
    start_datetime Date.new(2016,1,1)
    end_datetime Date.new(2016,1,10)
    player_limit 10

    after(:create) do |tournament|
      create_list :team, 2, tournament: tournament
    end

    factory :tournament_start_after_end do
      start_datetime Date.new(2016,1,11)
    end
  end
end