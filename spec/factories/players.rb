FactoryGirl.define do
  factory :player do
    team
    user

    after(:create) do |player|
      create_list :score, 2, player: player
    end
  end
end