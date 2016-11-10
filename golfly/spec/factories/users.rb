FactoryGirl.define do
  factory :user do
    fname 'Joe'
    lname 'Blow'
    email 'joe.blow@hotmail.com'
    dob Date.new(1994,4,4)
    bio 'This is a bio of me. I am Joe Blow'
  end
end