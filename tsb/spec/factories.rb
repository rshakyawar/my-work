Factory.sequence :name do |n|
  "name_#{n}"
end

Factory.sequence :email do |n|
  "email_#{n}@example.com"
end

Factory.define :user do |user|
  user.email { Factory.next(:email) }
  user.password 'password'
  user.password_confirmation 'password'
end

Factory.define :profile, :parent => :user do |profile|
  profile.first_name { Factory.next(:name) }
  profile.last_name { Factory.next(:name) }
  profile.address '123 main street'
  profile.city 'New York'
  profile.state 'US'
  profile.zip '10010'
  profile.phone '4051233333'
  profile.age '30'
  profile.gender 'm'
  profile.occupation 'Bank Teller'
  profile.income '50000'
  profile.size_show '10D'
  profile.size_waist '34'
  profile.size_inseam '32'
  profile.size_shirt 'XL'
end
