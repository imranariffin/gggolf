FactoryGirl.define do
  factory :user do
    fname 'Joe'
    lname 'Blow'
    addr '15 Old House Ln., Chappaqua, NY'
    email 'joe.blow@hotmail.com'
    bio 'This is a bio of me. I am Joe Blow'
    password 'password'
  end
end