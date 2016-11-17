FactoryGirl.define do
  factory :team do
    tournament

    after(:create) do |team|
      create_list :player, 5, team: team
    end
  end
end